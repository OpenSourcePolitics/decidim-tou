# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe UserInterestsForm do
    subject do
      described_class.from_model(user)
    end

    let!(:organization) { create(:organization) }
    let!(:user) { create(:user, organization: organization) }
    let!(:scope_0) { create(:scope, name: { en: "3.1 Scope", fr: "0 Scope" }, organization: organization) }
    let!(:scope_1) { create(:scope, name: { en: "1.1 A Scope", fr: "1 Scope" }, organization: organization) }
    let!(:scope_2) { create(:scope, name: { en: "1 Scope", fr: "1.1 A Scope" }, organization: organization) }
    let!(:scope_3) { create(:scope, name: { en: "1.1 B Scope", fr: "1.1 B Scope" }, organization: organization) }
    let!(:scope_4) { create(:scope, name: { en: "0 Scope", fr: "3.1 Scope" }, organization: organization) }
    let!(:scope_5) { create(:scope, name: { en: "3.2 Scope", fr: "3.2 Scope" }, organization: organization) }

    describe "#map_model" do
      it "returns an array of UserInterestScopeForm" do
        expect(subject.scopes.collect(&:id)).to eq([scope_4.id, scope_2.id, scope_1.id, scope_3.id, scope_0.id, scope_5.id])
      end

      context "when locale change" do
        before do
          allow(I18n).to receive(:locale).and_return(:fr)
        end

        it "returns an array of UserInterestScopeForm" do
          expect(subject.scopes.collect(&:id)).to eq([scope_0.id, scope_1.id, scope_2.id, scope_3.id, scope_4.id, scope_5.id])
        end
      end
    end
  end
end
