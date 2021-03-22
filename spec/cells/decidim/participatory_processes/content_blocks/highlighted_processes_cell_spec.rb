# frozen_string_literal: true

require "spec_helper"

describe "Highlighted processes cell", type: :cell do
  subject { cell(content_block.cell, content_block).call }

  let(:content_block) { create :content_block, organization: organization, manifest_name: :highlighted_processes, scope_name: :homepage, settings: settings }
  let(:organization) { create(:organization) }
  let!(:processes) { create_list :participatory_process, 5, organization: organization }
  let(:settings) { {} }

  controller Decidim::PagesController

  before do
    Decidim.available_locales = [:en]
    Decidim.default_locale = :en
    allow(controller).to receive(:current_organization).and_return(organization)
  end

  context "when the content block has no settings" do
    it "shows 4 processes" do
      within "#highlighted-processes" do
        expect(subject).to have_selector(".card--process", count: 4)
      end
    end
  end

  context "when the process has linked assemblies" do
    let(:participatory_process) { processes.first }
    let!(:published_assembly) { create(:assembly, :published, organization: organization) }
    let!(:unpublished_assembly) { create(:assembly, :unpublished, organization: organization) }
    let!(:private_assembly) { create(:assembly, :published, :private, :opaque, organization: organization) }
    let!(:transparent_assembly) { create(:assembly, :published, :private, :transparent, organization: organization) }

    before do
      published_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      unpublished_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      private_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      transparent_assembly.link_participatory_space_resources(participatory_process, "included_participatory_processes")
      visit decidim_participatory_processes.participatory_process_path(participatory_process)
    end

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
