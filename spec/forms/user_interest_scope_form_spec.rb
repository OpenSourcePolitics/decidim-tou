# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe UserInterestScopeForm do
    subject { described_class.from_model(scope: top_level_scope, user: user) }

    let!(:organization) { create(:organization) }
    let!(:top_level_scope) { create(:scope, organization: organization) }
    let!(:user) { create(:user, organization: organization) }

    describe "#map_model" do
      it "returns scope id" do
        expect(subject.id).to eq(top_level_scope.id)
      end

      it "returns name" do
        expect(subject.name).to eq(top_level_scope.name)
      end

      it "returns checked" do
        expect(subject.checked).to eq(false)
      end

      it "returns children" do
        expect(subject.children).to eq([])
      end

      context "when children are provided" do
        let!(:subscope_1) { create(:subscope, name: { en: "1.2 A Scope" }, parent: top_level_scope) }
        let!(:subscope_2) { create(:subscope, name: { en: "1.1 A Scope" }, parent: top_level_scope) }
        let!(:subscope_3) { create(:subscope, name: { en: "1.4 A Scope" }, parent: top_level_scope) }
        let!(:subscope_4) { create(:subscope, name: { en: "1.3 A Scope" }, parent: top_level_scope) }

        it "returns an array of UserInterestScopeForm" do
          expect(subject.children.collect(&:id)).to eq([subscope_2.id, subscope_1.id, subscope_4.id, subscope_3.id])
        end

        context "when grand children are provided" do
          let!(:child_subscope_1) { create(:subscope, name: { en: "1.2.1 A Scope" }, parent: subscope_1) }
          let!(:child_subscope_2) { create(:subscope, name: { en: "1.2.2 A Scope" }, parent: subscope_1) }
          let!(:child_subscope_3) { create(:subscope, name: { en: "1.4.1 A Scope" }, parent: subscope_2) }
          let!(:child_subscope_4) { create(:subscope, name: { en: "1.3.1 A Scope" }, parent: subscope_2) }

          it "returns an array of UserInterestScopeForm" do
            expect(subject.children.collect(&:id)).to eq([subscope_2.id, subscope_1.id, subscope_4.id, subscope_3.id])
            expect(subject.children[0].children.collect(&:id)).to eq([child_subscope_4.id, child_subscope_3.id])
            expect(subject.children[1].children.collect(&:id)).to eq([child_subscope_1.id, child_subscope_2.id])
          end
        end
      end
    end
  end
end
