# frozen_string_literal: true

require "spec_helper"

def fill_registration_form(params = {})
  if params[:step] == 1
    within "ol.horizontal__steps" do
      expect(page).to have_css("li:first-child", class: "step--active")
      expect(page).not_to have_css("li:last-child", class: "step--active")
    end

    fill_in :registration_user_email, with: "nikola.tesla@example.org"
    fill_in :registration_user_password, with: "sekritpass123"
    fill_in :registration_user_password_confirmation, with: "sekritpass123"
    check("registration_user_tos_agreement")
  else
    within "ol.horizontal__steps" do
      expect(page).not_to have_css("li:first-child", class: "step--active")
      expect(page).to have_css("li:last-child", class: "step--active")
    end

    fill_in :registration_user_name, with: "Nikola Tesla"
    fill_in :registration_user_nickname, with: "the-greatest-genius-in-history"
    select translated(scopes.first.name), from: :registration_user_residential_area
    select translated(scopes.first.name), from: :registration_user_work_area
    select "Other", from: :registration_user_gender
    select "September", from: :registration_user_month
    select "1992", from: :registration_user_year
    check :registration_underage_registration
    fill_in :registration_user_statutory_representative_email, with: "milutin.tesla@example.org"
  end
end

def submit_form
  within("form.new_user") do
    find("*[type=submit]").click
  end
end

describe "Registration", type: :system do
  let!(:scopes) { create_list(:scope, 5, organization: organization) }
  let(:organization) { create(:organization) }
  let!(:terms_and_conditions_page) { Decidim::StaticPage.find_by(slug: "terms-and-conditions", organization: organization) }
  let!(:another_user) { create(:user, organization: organization) }

  before do
    switch_to_host(organization.host)
    visit decidim.new_user_registration_path
  end

  context "when signing up" do
    describe "on first sight" do
      it "shows fields empty" do
        expect(page).to have_content("Sign up to participate")
        expect(page).to have_field("registration_user_email", with: "")
        expect(page).to have_field("registration_user_password", with: "")
        expect(page).to have_field("registration_user_password_confirmation", with: "")
        expect(page).to have_field("registration_user_newsletter", checked: false)
      end
    end

    describe "after clicking in next step" do
      it "forces user to fill first step attributes" do
        expect(page).to have_button("Continue", disabled: true)

        expect(page).to have_field("registration_user_email", with: "")
        expect(page).to have_field("registration_user_password", with: "")
        expect(page).to have_field("registration_user_password_confirmation", with: "")
        expect(page).not_to have_field("registration_user_name", with: "")
        expect(page).not_to have_field("registration_user_nickname", with: "")
      end

      context "when a mandatory field is missing" do
        it "forces user to fill first step attributes" do
          fill_registration_form(step: 1)
          fill_in :registration_user_email, with: ""

          expect(page).to have_button("Continue", disabled: true)
          expect(find_field(:registration_user_email)[:class]).to eq("is-invalid-input")
        end
      end

      context "when multiples mandatory fields are missing" do
        it "forces user to fill first step attributes" do
          fill_registration_form(step: 1)
          fill_in :registration_user_email, with: ""
          fill_in :registration_user_password, with: ""

          expect(page).to have_button("Continue", disabled: true)
          expect(find_field(:registration_user_email)[:class]).to eq("is-invalid-input")
          expect(find_field(:registration_user_password)[:class]).to eq("is-invalid-input")
        end
      end

      context "when a password confirmation doesn't match" do
        it "forces user to fill first step attributes" do
          fill_registration_form(step: 1)
          fill_in :registration_user_password_confirmation, with: "no-match"

          expect(page).to have_button("Continue", disabled: true)
          expect(find_field(:registration_user_password_confirmation)[:class]).to eq("is-invalid-input")
        end
      end

      it "shows fields empty" do
        fill_registration_form(step: 1)
        click_button "Continue"

        expect(page).not_to have_field("registration_user_email")
        expect(page).not_to have_field("registration_user_password")
        expect(page).not_to have_field("registration_user_password_confirmation")
        expect(page).to have_field("registration_user_name", with: "")
        expect(page).to have_field("registration_user_nickname", with: "")
        expect(page).to have_select("user[residential_area]", selected: "Please select")
        expect(page).to have_select("user[work_area]", selected: "Please select")
        expect(page).to have_select("user[gender]", selected: "Please select")
        expect(page).to have_select("user[month]", selected: "Please select")
        expect(page).to have_select("user[year]", selected: "Please select")
        expect(page).to have_unchecked_field("Underage")
      end
    end
  end

  context "when newsletter checkbox is unchecked" do
    it "opens modal on submit" do
      fill_registration_form(step: 1)
      click_button "Continue"

      fill_registration_form(step: 2)
      submit_form

      expect(page).to have_css("#sign-up-newsletter-modal")
      expect(page).to have_current_path decidim.new_user_registration_path
    end

    it "checks when clicking the checking button and user is created" do
      fill_registration_form(step: 1)
      click_button "Continue"

      fill_registration_form(step: 2)
      submit_form

      expect do
        click_button "Check and continue"
      end.to change(Decidim::User, :count).by(1)

      user = Decidim::User.last

      expect(user.newsletter_notifications_at).not_to be_nil
    end

    it "submit after modal has been opened and selected an option" do
      fill_registration_form(step: 1)
      click_button "Continue"
      fill_registration_form(step: 2)
      submit_form

      expect do
        click_button "Keep uncheck"
      end.to change(Decidim::User, :count).by(1)

      expect(Decidim::User.last.newsletter_notifications_at).to be_nil
    end
  end

  context "when newsletter checkbox is checked but submit fails" do
    before do
      fill_registration_form(step: 1)
      page.check("registration_user_newsletter")
      click_button "Continue"

      fill_registration_form(step: 2)
      fill_in :registration_user_nickname, with: another_user.nickname
      submit_form
    end

    it "shows all registration fields" do
      expect(page).to have_content("Sign up to participate")
      expect(page).to have_field("registration_user_email")
      expect(page).to have_field("registration_user_password")
      expect(page).to have_field("registration_user_password_confirmation")
      expect(page).to have_field("registration_user_name")
      expect(page).to have_field("registration_user_nickname")

      expect(page).to have_field("registration_underage_registration", checked: true)
      expect(page).to have_field(:registration_user_statutory_representative_email, with: "milutin.tesla@example.org")
    end

    it "keeps the user newsletter checkbox true value" do
      expect(page).to have_current_path decidim.user_registration_path
      expect(page).to have_field("registration_user_newsletter", checked: true)
    end
  end

  context "when newsletter checkbox is checked and registration is successful" do
    before do
      fill_registration_form(step: 1)
      page.check("registration_user_newsletter")
      click_button "Continue"
      fill_registration_form(step: 2)
    end

    it "creates the user" do
      expect do
        submit_form
      end.to change(Decidim::User, :count).by(1)

      user = Decidim::User.last

      expect(user.newsletter_notifications_at).not_to be_nil
    end
  end

  context "when registering with additional fields" do
    before do
      fill_registration_form(step: 1)
      page.check("registration_user_newsletter")
      click_button "Continue"
      fill_registration_form(step: 2)
    end

    it "allows user to register" do
      submit_form

      expect(page).to have_content("Welcome! You have signed up successfully.")
    end
  end
end
