# frozen_string_literal: true

module UserExportSerializerExtends
  # Public: Exports a hash with the serialized data for the user including extra user fields
  def serialize
    {
      id: resource.id,
      email: resource.email,
      name: resource.name,
      nickname: resource.nickname,
      organization: {
        id: resource.organization.try(:id),
        name: resource.organization.try(:name)
      },
      invitation_created_at: resource.invitation_created_at,
      invitation_sent_at: resource.invitation_sent_at,
      invitation_accepted_at: resource.invitation_accepted_at,
      invited_by: {
        id: resource.invited_by_id,
        type: resource.invited_by_type
      },
      invitations_count: resource.invitations_count,
      sign_in_count: resource.sign_in_count,
      last_sign_in_at: resource.last_sign_in_at,
      created_at: resource.created_at,
      updated_at: resource.updated_at,
      confirmed_at: resource.confirmed_at,
      unconfirmed_email: resource.unconfirmed_email,
      delete_reason: resource.delete_reason,
      deleted_at: resource.deleted_at,
      admin: resource.admin,
      accepted_tos_version: resource.accepted_tos_version,
      managed: resource.managed,
      officialized_at: resource.officialized_at,
      officialized_as: resource.officialized_as,
      age_scope: age_scope(fetch_age)
    }.merge(extra_fields)
  end

  private

  def admin_extra_fields
    return "" unless @private_scope && block_given?

    yield
  end

  def fetch_age
    age = key_from_registration_metadata(resource, :birth_date)
    return age.fetch("year", "") if age.is_a? Hash

    age
  end
end

Decidim::UserExporter::UserExportSerializer.class_eval do
  prepend(UserExportSerializerExtends)
end
