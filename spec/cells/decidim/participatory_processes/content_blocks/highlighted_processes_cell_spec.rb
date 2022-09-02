# frozen_string_literal: true

require "spec_helper"

describe Decidim::ParticipatoryProcesses::ContentBlocks::HighlightedProcessesCell, type: :cell do
  subject { cell(content_block.cell, content_block).call }

  let(:organization) { create(:organization) }
  let(:content_block) { create :content_block, organization: organization, manifest_name: :highlighted_processes, scope_name: :homepage, settings: settings }
  let!(:processes) { create_list :participatory_process, 5, organization: organization, display_linked_assemblies: display_linked_assemblies }
  let(:settings) { {} }
  let(:participatory_process) { processes.first }
  let(:display_linked_assemblies) { false }

  controller Decidim::PagesController

  before do
    allow(controller).to receive(:current_organization).and_return(organization)
  end

  it "does not show linked assemblies" do
    within "#highlighted-processes" do
      expect(subject).not_to have_selector(".linked_assemblies")
    end
  end

  context "when there is linked assemblies" do
    let!(:published_assembly) { create(:assembly, :published, title: { "en" => "2.1 Example title" }, organization: organization) }
    let!(:published_assembly_2) { create(:assembly, :published, title: { "en" => "1.3 Example title" }, organization: organization) }
    let!(:unpublished_assembly) { create(:assembly, :unpublished, organization: organization) }
    let!(:private_assembly) { create(:assembly, :published, :private, :opaque, organization: organization) }
    let!(:transparent_assembly) { create(:assembly, :published, :private, :transparent, title: { "en" => "2.2 Example title" }, organization: organization) }

    before do
      published_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      published_assembly_2.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      unpublished_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      private_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      transparent_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
    end

    context "and displaying linked assemblies is enabled" do
      let(:display_linked_assemblies) { true }

      it "shows linked assemblies" do
        within "#highlighted-processes" do
          expect(subject).to have_selector(".linked_assemblies")
        end
      end

      it "sorts published linked assemblies" do
        expect(subject.find(".linked_assemblies a:first-child").text.strip).to eq("1.3 Example title")
        expect(subject.find(".linked_assemblies a:nth-child(2)").text.strip).to eq("2.1 Example title")
        expect(subject.find(".linked_assemblies a:nth-child(3)").text.strip).to eq("2.2 Example title")
      end
    end

    context "and displaying linked assemblies is disabled" do
      let(:display_linked_assemblies) { false }

      it "doesn't show linked assemblies" do
        within "#highlighted-processes" do
          expect(subject).not_to have_selector(".linked_assemblies")
        end
      end
    end
  end

  context "when the content block has no settings" do
    it "shows 4 processes" do
      within "#highlighted-processes" do
        expect(subject).to have_selector(".card--process", count: 4)
      end
    end
  end

  context "when the content block has customized the welcome text setting value" do
    let(:settings) do
      {
        "max_results" => "8"
      }
    end

    it "shows up to 8 processes" do
      within "#highlighted-processes" do
        expect(subject).to have_selector(".card--process", count: 5)
      end
    end
  end
end
