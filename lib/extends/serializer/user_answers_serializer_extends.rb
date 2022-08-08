# frozen_string_literal: true

module UserAnswersSerializerExtends
  private

  def hash_for(answer)
    user = user_for answer
    {
      answer_translated_attribute_name(:id) => answer&.session_token,
      answer_translated_attribute_name(:user_nickname) => user.try(:nickname) || "",
      answer_translated_attribute_name(:user_email) => user.try(:email) || "",
      answer_translated_attribute_name(:created_at) => answer&.created_at&.to_s(:db),
      answer_translated_attribute_name(:ip_hash) => answer&.ip_hash,
      answer_translated_attribute_name(:user_status) => answer_translated_attribute_name(answer&.decidim_user_id.present? ? "registered" : "unregistered")
    }
  end

  def user_for(answer)
    return nil if answer.decidim_user_id.blank?

    Decidim::User.find answer.decidim_user_id
  end
end

Decidim::Forms::UserAnswersSerializer.class_eval do
  prepend(UserAnswersSerializerExtends)
end
