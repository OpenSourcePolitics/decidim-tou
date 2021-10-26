# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Devise
    describe ScopesController, type: :controller do
      routes { Decidim::Core::Engine.routes }

      let(:organization) { create :organization }
      let!(:scope_0) { create(:scope, name: { en: "0 Scope" }, organization: organization) }
      let!(:scope_1) { create(:scope, name: { en: "1 Scope" }, organization: organization) }
      let!(:scope_2) { create(:scope, name: { en: "1.1 A Scope" }, organization: organization) }
      let!(:scope_3) { create(:scope, name: { en: "1.1 B Scope" }, organization: organization) }
      let!(:scope_4) { create(:scope, name: { en: "3.1 Scope" }, organization: organization) }
      let!(:scope_5) { create(:scope, name: { en: "3.2 Scope" }, organization: organization) }

      let(:scopes) do
        [scope_0, scope_1, scope_2, scope_3, scope_4, scope_5].shuffle
      end

      before do
        request.env["decidim.current_organization"] = organization
      end

      describe "#order" do
        it "returns ordered scopes" do
          expect(subject.send(:order, organization.scopes)).to eq([scope_0, scope_1, scope_2, scope_3, scope_4, scope_5])
        end
      end
    end
  end
end
