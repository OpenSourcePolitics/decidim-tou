# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe ParticipatoryProcess do
    subject { participatory_process }

    let(:participatory_process) { build(:participatory_process, slug: "my-slug", organization: organization, display_linked_assemblies: display_linked_assemblies) }
    let(:organization) { create(:organization) }
    let(:display_linked_assemblies) { false }

    it { is_expected.to be_valid }

    it { is_expected.to be_versioned }

    it_behaves_like "publicable"
    it_behaves_like "has private users"

    it "overwrites the log presenter" do
      expect(described_class.log_presenter_class_for(:foo))
        .to eq Decidim::ParticipatoryProcesses::AdminLog::ParticipatoryProcessPresenter
    end

    context "when there's a process with the same slug in the same organization" do
      let!(:external_process) { create :participatory_process, organization: participatory_process.organization, slug: "my-slug" }

      it "is not valid" do
        expect(subject).not_to be_valid
        expect(subject.errors[:slug]).to eq ["has already been taken"]
      end
    end

    context "when there's a process with the same slug in another organization" do
      let!(:external_process) { create :participatory_process, slug: "my-slug" }

      it { is_expected.to be_valid }
    end

    describe "#active?" do
      context "when it ends in the past" do
        it "returns false" do
          participatory_process.end_date = 1.day.ago
          expect(participatory_process).not_to be_active
        end
      end

      context "when it starts before today and ends in the future" do
        it "returns true" do
          participatory_process.start_date = 1.week.ago
          participatory_process.end_date = 1.week.from_now
          expect(participatory_process).to be_active
        end
      end

      context "when it starts today and ends in the future" do
        it "returns true" do
          participatory_process.start_date = Date.current
          participatory_process.end_date = 1.week.from_now
          expect(participatory_process).to be_active
        end
      end

      context "when it ends today" do
        it "returns true" do
          participatory_process.start_date = 1.week.ago
          participatory_process.end_date = Date.current
          expect(participatory_process).to be_active
        end
      end

      context "when it starts in the future and ends in the future" do
        it "returns false" do
          participatory_process.end_date = 1.day.from_now
          expect(participatory_process).not_to be_past
        end
      end

      context "when it doesn't have an end date" do
        it "returns false" do
          participatory_process.end_date = nil
          expect(participatory_process).not_to be_past
        end
      end
    end

    describe "#past?" do
      context "when it ends in the past" do
        it "returns true" do
          participatory_process.end_date = 1.day.ago
          expect(participatory_process).to be_past
        end
      end

      context "when it ends in the future" do
        it "returns false" do
          participatory_process.end_date = 1.day.from_now
          expect(participatory_process).not_to be_past
        end
      end

      context "when it doesn't have an end date" do
        it "returns false" do
          participatory_process.end_date = nil
          expect(participatory_process).not_to be_past
        end
      end
    end

    describe "scopes" do
      let!(:past) { create :participatory_process, :past }
      let!(:upcoming) { create :participatory_process, :upcoming }
      let!(:active) { create :participatory_process, :active }
      let!(:ends_today) { create :participatory_process, start_date: 1.month.ago, end_date: Date.current }

      describe "active_spaces" do
        it "returns the currently active ones" do
          expect(described_class.active_spaces).to match_array [active, ends_today]
          expect(described_class.active_spaces).not_to include past
          expect(described_class.active_spaces).not_to include upcoming
        end
      end

      describe "future_spaces" do
        it "returns the future ones" do
          expect(described_class.future_spaces).not_to include active
          expect(described_class.future_spaces).not_to include past
          expect(described_class.future_spaces).to include upcoming
        end
      end

      describe "past_spaces" do
        it "returns the past ones" do
          expect(described_class.past_spaces).not_to include active
          expect(described_class.past_spaces).to include past
          expect(described_class.past_spaces).not_to include upcoming
        end
      end

      describe "#linked_assemblies" do
        context "when there is linked assemblies to PP" do
          let!(:published_assembly) { create(:assembly, :published, title: { "en" => "2.1 Example title" }, organization: organization) }
          let!(:transparent_assembly) { create(:assembly, :published, :private, :transparent, title: { "en" => "1.2 Example title" }, organization: organization) }
          let!(:unpublished_assembly) { create(:assembly, :unpublished, organization: organization) }
          let!(:private_assembly) { create(:assembly, :published, :private, :opaque, organization: organization) }

          before do
            published_assembly.link_participatory_space_resources(subject, "included_participatory_processes")
            unpublished_assembly.link_participatory_space_resources(subject, "included_participatory_processes")
            private_assembly.link_participatory_space_resources(subject, "included_participatory_processes")
            transparent_assembly.link_participatory_space_resources(subject, "included_participatory_processes")
          end

          context "and display_linked_assemblies is not enabled" do
            it "doesn't return the linked assemblies" do
              expect(subject.linked_assemblies).to be_nil
            end
          end

          context "and display_linked_assemblies is enabled" do
            let(:display_linked_assemblies) { true }

            it "returns the linked_assemblies" do
              expect(subject.linked_assemblies).to include(published_assembly)
              expect(subject.linked_assemblies).to include(transparent_assembly)
              expect(subject.linked_assemblies).not_to include(unpublished_assembly)
              expect(subject.linked_assemblies).not_to include(private_assembly)
            end

            it "sorts published linked assemblies" do
              expect(subject.linked_assemblies.map(&:id)).to eq([transparent_assembly.id, published_assembly.id])
            end
          end
        end
      end
    end
  end
end
