# frozen_string_literal: true

# Overrides Decidim::Proposals::ProposalSerializer
module ProposalSerializerExtend
  # Public: Exports a hash with the serialized data for this proposal.
  def serialize
    {
      t_column_name(:id) => proposal.id,
      t_column_name(:username) => creator_username,
      t_column_name(:email) => creator_email,
      t_column_name(:phone_number) => creator_phone_number,
      t_column_name(:category, ".category") => {
        t_column_name(:id, ".category") => proposal.category.try(:id),
        t_column_name(:name, ".category") => proposal.category.try(:name) || empty_translatable
      },
      t_column_name(:scope, ".scope") => {
        t_column_name(:id, ".scope") => proposal.scope.try(:id),
        t_column_name(:name, ".scope") => proposal.scope.try(:name) || empty_translatable
      },
      t_column_name(:participatory_space, ".participatory_space") => {
        t_column_name(:id, ".participatory_space") => proposal.participatory_space.id,
        t_column_name(:url, ".participatory_space") => Decidim::ResourceLocatorPresenter.new(proposal.participatory_space).url
      },
      t_column_name(:component, ".component") => { t_column_name(:id, ".component") => component.id },
      t_column_name(:title) => proposal.title,
      t_column_name(:body) => proposal.body,
      t_column_name(:address) => proposal.address,
      t_column_name(:latitude) => proposal.latitude,
      t_column_name(:longitude) => proposal.longitude,
      t_column_name(:state) => proposal.state.to_s,
      t_column_name(:reference) => proposal.reference,
      t_column_name(:answer) => ensure_translatable(proposal.answer),
      t_column_name(:supports) => proposal.proposal_votes_count,
      t_column_name(:endorsements, ".endorsements") => {
        t_column_name(:total_count, ".endorsements") => proposal.endorsements.size,
        t_column_name(:user_endorsements, ".endorsements") => user_endorsements
      },
      t_column_name(:comments) => proposal.comments_count,
      t_column_name(:attachments) => proposal.attachments.size,
      t_column_name(:followers) => proposal.follows.size,
      t_column_name(:published_at) => proposal.published_at,
      t_column_name(:url) => url,
      t_column_name(:meeting_urls) => meetings,
      t_column_name(:related_proposals) => related_proposals,
      t_column_name(:is_amend) => proposal.emendation?,
      t_column_name(:original_proposal, ".original_proposal") => {
        t_column_name(:title, ".original_proposal") => proposal&.amendable&.title,
        t_column_name(:url, ".original_proposal") => original_proposal_url
      }
    }
  end

  protected

  def i18n_scope
    "decidim.proposals.admin.exports.column_name.proposal"
  end

  def creator_username
    return "" if proposal.creator_identity.blank?

    proposal.creator_identity.try(:user_name).presence || proposal.creator_identity.try(:name).presence || ""
  end

  def creator_email
    return "" if proposal.creator_identity.blank?

    proposal.creator_identity.try(:email).presence || ""
  end

  def creator_phone_number
    return "" if proposal.creator_identity.blank?

    return "" if proposal.creator_identity.try(:id).blank?

    phone_number(proposal.creator_identity.try(:id))
  end

  # phone_number retrieve the phone number of an user stored from phone_authorization_handler
  # Param: user_id : Integer
  # Return string, empty or with the phone number
  def phone_number(user_id)
    authorization = Decidim::Authorization.find_by(name: "phone_authorization_handler", decidim_user_id: user_id)
    metadata = authorization.try(:metadata)
    return "" if metadata.blank?

    metadata.to_h["phone_number"].presence || ""
  end
end

Decidim::Proposals::ProposalSerializer.class_eval do
  prepend(ProposalSerializerExtend)
end
