# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe RegistrationForm do
    subject do
      described_class.from_params(
        attributes
      ).with_context(
        context
      )
    end

    let(:organization) { create(:organization) }
    let(:city_residential_scope) { create(:scope, organization: organization) }
    let(:city_work_scope) { create(:scope, organization: organization) }

    let(:name) { "User" }
    let(:nickname) { "justme" }
    let(:email) { "user@example.org" }
    let(:password) { "S4CGQ9AM4ttJdPKS" }
    let(:password_confirmation) { password }
    let(:tos_agreement) { "1" }
    let(:additional_tos) { "1" }
    let(:living_area) { "City" }
    let(:city_residential_area) { city_residential_scope.id.to_s }
    let(:city_work_area) { city_work_scope.id.to_s }
    let(:gender) { "female" }
    let(:month) { "January" }
    let(:year) { "1992" }
    let(:underage) { true }
    let(:statutory_representative_email) { "statutory-representative@example.org" }

    let(:attributes) do
      {
        name: name,
        nickname: nickname,
        email: email,
        password: password,
        password_confirmation: password_confirmation,
        tos_agreement: tos_agreement,
        additional_tos: additional_tos,
        living_area: living_area,
        city_residential_area: city_residential_area,
        city_work_area: city_work_area,
        gender: gender,
        month: month,
        year: year,
        underage: underage,
        statutory_representative_email: statutory_representative_email
      }
    end

    let(:context) do
      {
        current_organization: organization
      }
    end

    context "when everything is OK" do
      it { is_expected.to be_valid }
    end

    context "when the email is a disposable account" do
      let(:email) { "user@mailbox92.biz" }

      it { is_expected.to be_invalid }
    end

    context "when the name is not present" do
      let(:name) { nil }

      it { is_expected.to be_invalid }
    end

    context "when the nickname is not present" do
      let(:nickname) { nil }

      it { is_expected.to be_invalid }
    end

    context "when the email is not present" do
      let(:email) { nil }

      it { is_expected.to be_invalid }
    end

    context "when the email already exists" do
      let!(:user) { create(:user, organization: organization, email: email) }

      it { is_expected.to be_invalid }

      context "and is pending to accept the invitation" do
        let!(:user) { create(:user, organization: organization, email: email, invitation_token: "foo", invitation_accepted_at: nil) }

        it { is_expected.to be_invalid }
      end
    end

    context "when the nickname already exists" do
      let!(:user) { create(:user, organization: organization, nickname: nickname) }

      it { is_expected.to be_invalid }

      context "and is pending to accept the invitation" do
        let!(:user) { create(:user, organization: organization, nickname: nickname, invitation_token: "foo", invitation_accepted_at: nil) }

        it { is_expected.to be_valid }
      end
    end

    context "when the nickname is too long" do
      let(:nickname) { "verylongnicknamethatcreatesanerror" }

      it { is_expected.to be_invalid }
    end

    context "when the password is not present" do
      let(:password) { nil }

      it { is_expected.to be_invalid }
    end

    context "when the password is weak" do
      let(:password) { "aaaabbbbcccc" }

      it { is_expected.to be_invalid }
    end

    context "when the password confirmation is not present" do
      let(:password_confirmation) { nil }

      it { is_expected.to be_invalid }
    end

    context "when the password confirmation is different from password" do
      let(:password_confirmation) { "invalid" }

      it { is_expected.to be_invalid }
    end

    context "when the tos_agreement is not accepted" do
      let(:tos_agreement) { "0" }

      it { is_expected.to be_invalid }
    end

    context "when the additional_tos is not accepted" do
      let(:additional_tos) { "0" }

      it { is_expected.to be_invalid }
    end

    context "when gender is not in list" do
      let(:gender) { "Apache helicopter" }

      it { is_expected.to be_invalid }
    end

    context "when gender is nil" do
      let(:gender) { nil }

      it { is_expected.to be_valid }
    end

    context "when birth_date year is not in the range" do
      let(:year) { "1000" }

      it { is_expected.to be_invalid }
    end

    context "when birth_date month is not in the list" do
      let(:month) { "Apple" }

      it { is_expected.to be_invalid }
    end

    context "when birth_date year is nil" do
      let(:year) { nil }

      it { is_expected.to be_invalid }
    end

    context "when birth_date month is nil" do
      let(:month) { nil }

      it { is_expected.to be_invalid }
    end

    context "when underage is unchecked" do
      let(:underage) { nil }

      it { is_expected.to be_valid }
    end

    context "when underage is checked but statutory_representative_email is nil" do
      let(:statutory_representative_email) { nil }

      it { is_expected.to be_invalid }
    end

    context "when living_area is nil" do
      let(:living_area) { nil }

      it { is_expected.to be_invalid }
    end

    context "when living_area is not in list" do
      let(:living_area) { "Outer space" }

      it { is_expected.to be_invalid }
    end

    context "when living_area is city" do
      context "when city_residential_area is not a scope" do
        let(:city_residential_area) { "23" }

        it { is_expected.to be_invalid }
      end

      context "when city_residential_area is nil" do
        let(:city_residential_area) { nil }

        it { is_expected.to be_invalid }
      end

      context "when city_work_area is not a scope" do
        let(:city_work_area) { "abcd" }

        it { is_expected.to be_invalid }
      end

      context "when city_work_area is nil" do
        let(:city_work_area) { nil }

        it { is_expected.to be_valid }
      end
    end

    context "when living_area is other" do
      let(:living_area) { "Other" }

      context "when everything is OK" do
        it { is_expected.to be_valid }
      end

      context "when city_residential_area is not a scope" do
        let(:city_residential_area) { "23" }

        it { is_expected.to be_valid }
      end

      context "when city_residential_area is nil" do
        let(:city_residential_area) { nil }

        it { is_expected.to be_valid }
      end

      context "when city_work_area is not a scope" do
        let(:city_work_area) { "abcd" }

        it { is_expected.to be_valid }
      end

      context "when city_work_area is nil" do
        let(:city_work_area) { nil }

        it { is_expected.to be_valid }
      end
    end

    describe "#city_scopes" do
      it "matches city scopes" do
        expect(subject.send(:city_scopes)).to match_array([
                                                            city_residential_scope,
                                                            city_work_scope
                                                          ])
      end
    end

    describe "#city_scopes_ids" do
      it "matches city scopes" do
        expect(subject.send(:city_scopes_ids)).to match_array([
                                                                city_residential_scope.id.to_s,
                                                                city_work_scope.id.to_s
                                                              ])
      end
    end
  end
end
