# frozen_string_literal: true

module Decidim
  module Surveys
    # Importer for Surveys specific data (this is, its questionnaire).
    class DataImporter < Decidim::Importers::Importer
      def initialize(component)
        @component = component
      end

      # Public: Creates a new Decidim::Surveys::Survey and Decidim::Forms::Questionnaire associated to the given +component+
      #         for each serialized survey object.
      # It imports the whole tree of Survey->Questionnaire->questions->answer_options.
      #
      # serialized        - The Hash of attributes for the Questionnaire and its relations.
      # user              - The +user+ that is performing this action
      #
      # Returns the ser.
      def import(serialized, user)
        ActiveRecord::Base.transaction do
          # we duplicate so that we can delete without affecting the received Hash
          serialized.dup.collect do |serialized_survey|
            reverse_translated = if serialized_survey.keys.first.is_a?(Symbol)
                                   serialized_survey
                                 else
                                   reverse_t(serialized_survey)
                                 end

            import_survey(reverse_translated, user)
          end
        end
      end

      private

      # Returns a persisted Survey instance build from +serialized_survey+.
      def import_survey(serialized_survey, user)
        serialized_survey = serialized_survey.with_indifferent_access
        survey = build_survey(serialized_survey)
        serialized_questionnaire = serialized_survey[:questionnaire]
        serialized_questions = serialized_questionnaire.delete(:questions)

        questionnaire = build_questionnaire(survey, serialized_questionnaire)
        Decidim.traceability.perform_action!(:create, Decidim::Surveys::Survey, user) do
          survey.save!
          survey
        end
        import_questions(questionnaire, serialized_questions)
        survey
      end

      def build_survey(_serialized)
        Survey.new(component: @component)
      end

      # Builds a Decidim::Forms::Questionnaire with all its questions and answer_options.
      def build_questionnaire(survey, serialized_questionnaire)
        survey.build_questionnaire(serialized_questionnaire.except(:id, :published_at))
      end

      def import_questions(questionnaire, serialized_questions)
        serialized_questions.each do |serialized_question|
          serialized_answer_options = serialized_question.delete(:answer_options)
          question = questionnaire.questions.create!(serialized_question.except(:id, :created_at, :updated_at))
          serialized_answer_options.each do |serialized_answer_option|
            question.answer_options.create!(serialized_answer_option.except(:id, :created_at, :updated_at))
          end
        end
      end

      def reverse_t(json_survey)
        reversed = {}
        reversed[:id] = json_survey["ID"]
        reversed[:decidim_component_id] = json_survey["ID du composant"]
        reversed[:created_at] = json_survey["Date de création"]
        reversed[:updated_at] = json_survey["Date de mise à jour"]
        reversed[:questionnaire] = reverse_questionnaire(json_survey["Questionnaire"])
        reversed[:survey_id] = json_survey["survey_id"]

        reversed
      end

      # rubocop:disable Metrics/PerceivedComplexity
      # rubocop:disable Metrics/CyclomaticComplexity
      def reverse_questionnaire(questionnaire)
        hash = {}
        hash[:id] = questionnaire["ID"]
        hash[:title] = questionnaire["Titre"]
        hash[:description] = questionnaire["Description"]
        hash[:tos] = questionnaire["Conditions d'utilisation"]
        hash[:questionnaire_for_type] = questionnaire["Type du questionnaire"]
        hash[:questionnaire_for_id] = questionnaire["ID du questionnaire"]
        hash[:published_at] = questionnaire["Date de publication"]
        hash[:created_at] = questionnaire["Date de création"]
        hash[:updated_at] = questionnaire["Date de mise à jour"]
        hash[:salt] = questionnaire["Hash"]
        hash[:questions] = reverse_questions(questionnaire["Questions"])

        hash
      end

      def reverse_questions(questions)
        questions.map do |hash|
          obj = {}
          obj[:id] = hash["ID"]
          obj[:body] = hash["Contenu"]
          obj[:position] = hash["Position"]
          obj[:question_type] = hash["Type de question"]
          obj[:mandatory] = hash["Obligatoire"]
          obj[:description] = hash["Description"]
          obj[:max_choices] = hash["Choix maximum"]
          obj[:max_characters] = hash["Caractères maximum"]
          obj[:created_at] = hash["Date de création"]
          obj[:updated_at] = hash["Date de mise à jour"]
          obj[:answer_options] = reverse_answer_options(hash["Options de réponse"])
          obj
        end
      end

      def reverse_answer_options(answers)
        answers.map do |hash|
          obj = {}
          obj[:id] = hash["ID"]
          obj[:decidim_question_id] = hash["ID de la question"]
          obj[:body] = hash["Contenu"]
          obj[:free_text] = hash["Texte libre"]
          obj
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity
      # rubocop:enable Metrics/CyclomaticComplexity

    end
  end
end
