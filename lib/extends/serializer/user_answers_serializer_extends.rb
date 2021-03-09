# frozen_string_literal: true

module UserAnswersSerializerExtends
  # Public: Exports a hash with the serialized data for the user answers.
  def serialize
    @answers.each_with_index.inject({}) do |serialized, (answer, idx)|
      serialized.update(
        answer_translated_attribute_name(:id) => answer.id,
        answer_translated_attribute_name(:created_at) => answer.created_at.to_s(:db),
        answer_translated_attribute_name(:ip_hash) => answer.ip_hash,
        answer_translated_attribute_name(:user_status) => answer_translated_attribute_name(answer.decidim_user_id.present? ? "registered" : "unregistered"),
        answer_translated_attribute_name(:registration_metadata) => registration_metadata(answer),
        "#{idx + 1}. #{translated_attribute(answer.question.body)}" => normalize_body(answer)
      )
    end
  end

  def registration_metadata(answer)
    return "" if answer.decidim_user_id.blank?

    Decidim::User.find(answer.decidim_user_id).registration_metadata || ""
  end
end

Decidim::Forms::UserAnswersSerializer.class_eval do
  prepend(UserAnswersSerializerExtends)
end
