# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Proposals
    describe ProposalSerializer do
      subject do
        described_class.new(proposal)
      end

      let!(:proposal) { create(:proposal, :accepted) }
      let!(:category) { create(:category, participatory_space: component.participatory_space) }
      let!(:scope) { create(:scope, organization: component.participatory_space.organization) }
      let(:participatory_process) { component.participatory_space }
      let(:component) { proposal.component }

      let!(:meetings_component) { create(:component, manifest_name: "meetings", participatory_space: participatory_process) }
      let(:meetings) { create_list(:meeting, 2, :published, component: meetings_component) }

      let!(:proposals_component) { create(:component, manifest_name: "proposals", participatory_space: participatory_process) }
      let(:other_proposals) { create_list(:proposal, 2, component: proposals_component) }

      let(:expected_answer) do
        answer = proposal.answer
        Decidim.available_locales.each_with_object({}) do |locale, result|
          result[locale.to_s] = if answer.is_a?(Hash)
                                  answer[locale.to_s] || ""
                                else
                                  ""
                                end
        end
      end

      before do
        proposal.update!(category: category)
        proposal.update!(scope: scope)
        proposal.link_resources(meetings, "proposals_from_meeting")
        proposal.link_resources(other_proposals, "copied_from_component")
      end

      describe "#serialize" do
        let(:serialized) { subject.serialize }

        it "serializes the id" do
          expect(serialized).to include("ID" => proposal.id)
        end

        it "serializes the author data" do
          expect(serialized).to include("Pseudo" => proposal.creator_identity&.user_name)
          expect(serialized).to include("Email" => proposal.creator_identity&.email)
        end

        it "serializes the id" do
          expect(serialized).to include("ID" => proposal.id)
        end

        it "serializes the category" do
          expect(serialized["Categorie"]).to include("ID" => category.id)
          expect(serialized["Categorie"]).to include("Nom" => category.name)
        end

        it "serializes the scope" do
          expect(serialized["Scope"]).to include("ID" => scope.id)
          expect(serialized["Scope"]).to include("Nom" => scope.name)
        end

        it "serializes the title" do
          expect(serialized).to include("Titre" => proposal.title)
        end

        it "serializes the body" do
          expect(serialized).to include("Contenu" => proposal.body)
        end

        it "serializes the address" do
          expect(serialized).to include("Adresse" => proposal.address)
        end

        it "serializes the latitude" do
          expect(serialized).to include("Latitude" => proposal.latitude)
        end

        it "serializes the longitude" do
          expect(serialized).to include("Longitude" => proposal.longitude)
        end

        it "serializes the amount of supports" do
          expect(serialized).to include("Supports" => proposal.proposal_votes_count)
        end

        it "serializes the amount of comments" do
          expect(serialized).to include("Commentaires" => proposal.comments_count)
        end

        it "serializes the date of creation" do
          expect(serialized).to include("Publiée le" => proposal.published_at)
        end

        it "serializes the url" do
          expect(serialized["URL"]).to include("http", proposal.id.to_s)
        end

        it "serializes the component" do
          expect(serialized["Composant"]).to include("ID" => proposal.component.id)
        end

        it "serializes the meetings" do
          expect(serialized["Urls de rencontre"].length).to eq(2)
          expect(serialized["Urls de rencontre"].first).to match(%r{http.*/meetings})
        end

        it "serializes the participatory space" do
          expect(serialized["Espace de participation"]).to include("ID" => participatory_process.id)
          expect(serialized["Espace de participation"]["URL"]).to include("http", participatory_process.slug)
        end

        it "serializes the state" do
          expect(serialized).to include("Statut" => proposal.state)
        end

        it "serializes the reference" do
          expect(serialized).to include("Reference" => proposal.reference)
        end

        it "serializes the answer" do
          expect(serialized).to include("Réponse" => expected_answer)
        end

        it "serializes the amount of attachments" do
          expect(serialized).to include("Pièces jointes" => proposal.attachments.count)
        end

        it "serializes the endorsements" do
          expect(serialized["Soutiens"]).to include("Total" => proposal.endorsements.count)
          expect(serialized["Soutiens"]).to include("Soutiens de l'utilisateur" => proposal.endorsements.for_listing.map { |identity| identity.normalized_author&.name })
        end

        it "serializes related proposals" do
          expect(serialized["Proposition liées"].length).to eq(2)
          expect(serialized["Proposition liées"].first).to match(%r{http.*/proposals})
        end

        it "serializes if proposal is_amend" do
          expect(serialized).to include("Est amendée" => proposal.emendation?)
        end

        it "serializes the original proposal" do
          expect(serialized["Proposition originale"]).to include("Titre" => proposal&.amendable&.title)
          expect(serialized["Proposition originale"]["URL"]).to be_nil || include("http", proposal.id.to_s)
        end

        context "with proposal having an answer" do
          let!(:proposal) { create(:proposal, :with_answer) }

          it "serializes the answer" do
            expect(serialized).to include("Réponse" => expected_answer)
          end
        end
      end
    end
  end
end
