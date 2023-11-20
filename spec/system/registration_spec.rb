# frozen_string_literal: true

require "spec_helper"
require_relative "examples/registration_password_examples"
require_relative "examples/registration_instant_validation_examples"
require_relative "examples/registration_hide_nickname_examples"

describe "Registration", type: :system do
  let(:organization) { create(:organization) }
  before do
    switch_to_host(organization.host)
  end

  it_behaves_like "on/off registration passwords"

  it_behaves_like "on/off registration instant validation"

  it_behaves_like "on/off registration hide nickname"

  # --------- NEWSLETTER MODAL TESTS ---------

  def fill_registration_form
    fill_in :registration_user_name, with: "Nikola Tesla"
    fill_in :registration_user_email, with: "nikola.tesla@example.org"
    fill_in :registration_user_password, with: "sekritpass123"

    select "City", from: :registration_user_living_area
    select translated(city_residential_area.name), from: :registration_user_city_residential_area
    select translated(city_work_area.name), from: :registration_user_city_work_area
    select "Other", from: :registration_user_gender
    select "September", from: :registration_user_month
    select "1992", from: :registration_user_year
    check :registration_user_tos_agreement
    check :registration_user_additional_tos
  end

  context "when signing up" do
    let!(:city_residential_area) { create(:scope, parent: city_parent_scope) }
    let!(:city_work_area) { create(:scope, parent: city_parent_scope) }

    let!(:city_parent_scope) do
      create(:scope,
             id: 58,
             name: {
               fr: "Ville de Toulouse",
               en: "Toulouse city"
             },
             organization: organization)
    end
    let!(:metropolis_parent_scope) do
      create(:scope,
             id: 59,
             name: {
               fr: "Métropole de Toulouse",
               en: "Toulouse metropolis"
             },
             organization: organization)
    end

    before do
      allow(Decidim::FriendlySignup).to receive(:hide_nickname).and_return(true)
      visit decidim.new_user_registration_path
    end

    describe "on first sight" do
      it "shows fields empty" do
        expect(page).to have_content("Sign up to participate")
        expect(page).to have_field("registration_user_name", with: "")
        expect(page).to have_field("registration_user_email", with: "")
        expect(page).to have_field("registration_user_password", with: "")
        expect(page).to have_field("registration_user_newsletter", checked: false)
      end
    end

    context "when newsletter checkbox is unchecked" do
      it "opens modal on submit" do
        within ".new_user" do
          find("*[type=submit]").click
        end
        expect(page).to have_css("#sign-up-newsletter-modal", visible: :visible)
      end

      it "checks when clicking the checking button" do
        fill_registration_form
        within ".new_user" do
          find("*[type=submit]").click
        end
        expect(page).to have_css("#sign-up-newsletter-modal", visible: :all)
        click_button "Check and continue"
      end

      it "submit after modal has been opened and selected an option" do
        within ".new_user" do
          find("*[type=submit]").click
        end
        click_button "Keep unchecked"
        expect(page).to have_css("#sign-up-newsletter-modal", visible: :all)
        fill_registration_form
        within ".new_user" do
          find("*[type=submit]").click
        end
        expect(page).to have_field("registration_user_newsletter", checked: false)
      end
    end

    context "when newsletter checkbox is checked but submit fails" do
      before do
        fill_registration_form
        page.check("registration_user_newsletter")
      end

      it "keeps the user newsletter checkbox true value" do
        expect(page).to have_field("registration_user_newsletter", checked: true)
        within ".new_user" do
          find("*[type=submit]").click
        end
      end
    end
  end
end
