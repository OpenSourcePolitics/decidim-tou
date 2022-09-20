# frozen_string_literal: true

require "spec_helper"

module Decidim::Surveys
  describe DataImporter do
    describe "#import" do
      subject do
        described_class.new(component).import(as_json, user)
      end

      let(:user) { create(:user) }
      let!(:original_questionnaire) { create(:questionnaire, :with_questions) }
      let!(:survey) { create(:survey, questionnaire: original_questionnaire) }
      let(:component) { survey.component }

      let(:as_json) do
        questionnaire_attrs = original_questionnaire.attributes
        questions = []
        original_questionnaire.questions.order(:position).each do |q|
          question_attrs = q.attributes
          answer_options = []
          q.answer_options.each do |answer_option|
            answer_options << answer_option.attributes
          end
          question_attrs[:answer_options] = answer_options
          questions << question_attrs
        end
        questionnaire_attrs[:questions] = questions
        [{
           id: rand(99_999),
           questionnaire: questionnaire_attrs
         }]
      end

      describe "#import" do
        let!(:imported) { subject }

        it "imports survey" do
          expect(imported.size).to eq(1)
          imported_survey = imported.first
          expect(imported_survey).to be_kind_of(Decidim::Surveys::Survey)
          expect(imported_survey).to be_persisted
          questionnaire = imported_survey.questionnaire
          expect(questionnaire).to be_kind_of(Decidim::Forms::Questionnaire)

          attribs_to_ignore = %w(id updated_at created_at questionnaire_for_id published_at)
          expected_attrs = original_questionnaire.attributes.except(*attribs_to_ignore)
          actual_attrs = questionnaire.attributes.except(*attribs_to_ignore)
          expect(actual_attrs.delete("published_at")).to be_nil
          expect(actual_attrs).to eq(expected_attrs)

          imported_questions_should_eq_serialized(questionnaire.questions)
        end

        context "when columns are translated" do
          subject do
            described_class.new(component).send(:reverse_t, as_json)
          end

          let(:as_json) do
            {
              "ID" => 136,
              "ID du composant" => 463,
              "Date de création" => "2022-08-30T13:38:35.058Z",
              "Date de mise à jour" => "2022-08-30T13:38:35.058Z",
              "Questionnaire" => {
                "ID" => 263,
                "Titre" => { "fr" => "Questionnaire" },
                "Description" => { "fr" => "" },
                "Conditions d'utilisation" => { "fr" => "<p>Lorem ipsum</p>" },
                "Type du questionnaire" => "Decidim::Surveys::Survey",
                "ID du questionnaire" => 136,
                "Date de publication" => nil,
                "Date de création" => "2022-08-30T13:38:35.073Z",
                "Date de mise à jour" => "2022-08-30T13:54:31.840Z",
                "Hash" => "aaaabbbbbb",
                "Questions" => [
                  { "ID" => 1214,
                    "Position" => 0,
                    "Type de question" => "short_answer",
                    "Obligatoire" => true,
                    "Contenu" => { "fr" => "Lorem ipsum" },
                    "Description" => { "fr" => "" },
                    "Choix maximum" => nil,
                    "Date de création" => "2022-08-30T13:54:31.673Z",
                    "Date de mise à jour" => "2022-08-30T14:17:35.069Z",
                    "Caractères maximum" => 25,
                    "Options de réponse" => [
                      {
                        "ID" => 1490,
                        "ID de la question" => 1214,
                        "Contenu" => {
                          "fr" => "Végétalisation"
                        },
                        "Texte libre" => false
                      },
                    ],
                  }
                ]
              },
              "survey_id" => 136
            }
          end

          it "transforms string keys to symbol" do
            expect(subject).to include(id: 136)
            expect(subject).to include(decidim_component_id: 463)
            expect(subject).to include(created_at: "2022-08-30T13:38:35.058Z")
            expect(subject).to include(updated_at: "2022-08-30T13:38:35.058Z")
            expect(subject).to include(survey_id: 136)
            expect(subject).to include(:questionnaire)
            expect(subject[:questionnaire]).to include(id: 263)
            expect(subject[:questionnaire]).to include(title: { "fr" => "Questionnaire" })
            expect(subject[:questionnaire]).to include(description: { "fr" => "" })
            expect(subject[:questionnaire]).to include(tos: { "fr" => "<p>Lorem ipsum</p>" })
            expect(subject[:questionnaire]).to include(questionnaire_for_type: "Decidim::Surveys::Survey")
            expect(subject[:questionnaire]).to include(questionnaire_for_id: 136)
            expect(subject[:questionnaire]).to include(published_at: nil)
            expect(subject[:questionnaire]).to include(created_at: "2022-08-30T13:38:35.073Z")
            expect(subject[:questionnaire]).to include(updated_at: "2022-08-30T13:54:31.840Z")
            expect(subject[:questionnaire]).to include(salt: "aaaabbbbbb")
            expect(subject[:questionnaire]).to include(:questions)
            expect(subject[:questionnaire][:questions].first).to include(id: 1214)
            expect(subject[:questionnaire][:questions].first).to include(position: 0)
            expect(subject[:questionnaire][:questions].first).to include(question_type: "short_answer")
            expect(subject[:questionnaire][:questions].first).to include(mandatory: true)
            expect(subject[:questionnaire][:questions].first).to include(body: { "fr" => "Lorem ipsum" })
            expect(subject[:questionnaire][:questions].first).to include(description: { "fr" => "" })
            expect(subject[:questionnaire][:questions].first).to include(max_choices: nil)
            expect(subject[:questionnaire][:questions].first).to include(created_at: "2022-08-30T13:54:31.673Z")
            expect(subject[:questionnaire][:questions].first).to include(updated_at: "2022-08-30T14:17:35.069Z")
            expect(subject[:questionnaire][:questions].first).to include(max_characters: 25)
            expect(subject[:questionnaire][:questions].first).to include(answer_options: [
              {
                id: 1490,
                decidim_question_id: 1214,
                body: {
                  "fr" => "Végétalisation"
                },
                free_text: false
              },
            ])
          end
        end
      end

      private

      def imported_questions_should_eq_serialized(imported_questions)
        original_questions = original_questionnaire.questions
        expect(imported_questions.size).to eq(original_questions.size)

        imported_questions.zip(original_questions).each do |imported, original|
          expect(imported.position).to eq(original.position)
          expect(imported.question_type).to eq(original.question_type)
          expect(imported.mandatory).to eq(original.mandatory)
          expect(imported.body).to eq(original.body)
          expect(imported.description).to eq(original.description)
          expect(imported.max_choices).to eq(original.max_choices)
          imported_question_options_should_eq_serialized(imported.answer_options, original.answer_options)
        end
      end

      def imported_question_options_should_eq_serialized(imported_answer_options, original_answer_options)
        expect(imported_answer_options.size).to eq(original_answer_options.size)
        imported_answer_options.zip(original_answer_options).each do |imported, original|
          expect(imported.body).to eq(original.body)
          expect(imported.free_text).to eq(original.free_text)
        end
      end
    end
  end
end
