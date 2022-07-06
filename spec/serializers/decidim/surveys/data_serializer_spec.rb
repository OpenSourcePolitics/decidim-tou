# frozen_string_literal: true

require "spec_helper"

module Decidim::Surveys
  describe DataSerializer do
    describe "#serialize" do
      subject do
        described_class.new(survey.component)
      end

      let!(:questionnaire) { build(:questionnaire, :with_questions) }
      let!(:survey) { create(:survey, questionnaire: questionnaire) }

      let(:serialized_surveys) { subject.serialize }

      it "serializes questionnaire" do
        expect(serialized_surveys.count).to eq(1)
        serialized_survey = serialized_surveys.first
        expect(serialized_survey["ID"]).to eq(survey.id)

        serialized_questionnaire = serialized_survey["Questionnaire"]
        expect(serialized_questionnaire["Titre"]).to eq(questionnaire.title)
        expect(serialized_questionnaire["Description"]).to eq(questionnaire.description)
        expect(serialized_questionnaire["Conditions d'utilisation"]).to eq(questionnaire.tos)
        expect(serialized_questionnaire["Type du questionnaire"]).to eq(survey.class.name)
        expect(serialized_questionnaire["ID du questionnaire"]).to eq(survey.id)
        expect(serialized_questionnaire["Date de publication"]).to eq(questionnaire.published_at)

        questions_should_be_as_expected(questionnaire.questions.order(:position), serialized_questionnaire["Questions"])
      end

      def questions_should_be_as_expected(questions, serializeds)
        expect(serializeds.size).to eq(3)
        num_expected_answers_list = [0, 0, 3]
        serializeds.zip(questions, num_expected_answers_list) do |serialized, question, num_expected_answers|
          expect(serialized["ID"]).to eq(question.id)
          expect(serialized["ID du questionnaire"]).to eq(question.decidim_questionnaire_id)
          expect(serialized["Position"]).to eq(question.position)
          expect(serialized["Type de question"]).to eq(question.question_type)
          expect(serialized["Obligatoire"]).to eq(question.mandatory)
          expect(serialized["Contenu"]).to eq(question.body)
          expect(serialized["Description"]).to eq(question.description)
          expect(serialized["Choix maximum"]).to eq(question.max_choices)

          options_should_be_as_expected(question.answer_options.order("ID"), serialized["Options de réponse"], num_expected_answers)
        end
      end

      def options_should_be_as_expected(answer_options, serializeds, num_expected)
        expect(serializeds.size).to eq(num_expected)
        serializeds.zip(answer_options) do |serialized, option|
          expect(serialized["ID"]).to eq(option.id)
          expect(serialized["ID de la question"]).to eq(option.decidim_question_id)
          expect(serialized["Contenu"]).to eq(option.body)
          expect(serialized["Texte libre"]).to eq(option.free_text)
        end
      end
    end
  end
end
