# frozen_string_literal: true

# Overrides Decidim::Surveys::ProposalSerializer
module DataSerializerExtend

  # Returns: Array of Decidim::Forms::Questionnaire as a json hash,
  #     or nil if none exists.
  def serialize
    component = resource
    surveys = Decidim::Surveys::Survey.where(component: component)
    surveys.collect do |survey|
      next if survey.questionnaire.nil?

      json = serialize_survey(survey)
      json.with_indifferent_access.merge(t_column_name(:survey_id) => survey.id)
    end
  end

  def serialize_survey(survey)
    questionnaire = survey.questionnaire
    questionnaire_json = t_attr(questionnaire)
    questionnaire_json[t_column_name(:questions)] = serialize_questions(questionnaire.questions.order(:position))
    json = t_attr(survey)
    json[t_column_name(:questionnaire)] = questionnaire_json
    json
  end

  def serialize_questions(questions)
    questions.collect do |question|
      json = t_attr(question)
      json[t_column_name(:answer_options)] = serialize_answer_options(question.answer_options)
      json
    end
  end

  def serialize_answer_options(answer_options)
    answer_options.collect do |option|
      t_attr(option)
    end
  end

  protected

  def i18n_scope
    "decidim.surveys.admin.exports.column_name.data"
  end

  def t_attr(obj)
    obj.as_json.deep_transform_keys do |key|
      t_column_name(key)
    end
  end
end

Decidim::Surveys::DataSerializer.class_eval do
  prepend(DataSerializerExtend)
end
