# frozen_string_literal: true

shared_examples "on/off registration passwords" do
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
    allow(Decidim::FriendlySignup).to receive(:hide_nickname).and_return(false)
    visit decidim.new_user_registration_path
  end

  context "when override_passwords is active" do
    it "does not show password confirmation" do
      expect(page).to have_content("Sign up to participate")
      expect(page).to have_field("registration_user_name", with: "")
      expect(page).to have_field("registration_user_nickname", with: "")
      expect(page).to have_field("registration_user_email", with: "")
      expect(page).to have_field("registration_user_password", with: "")
      expect(page).not_to have_field("registration_user_newsletter", checked: false)
    end

    it "creates a new User" do
      find(".sign-up-link").click

      within ".new_user" do
        fill_in :registration_user_email, with: "user@example.org"
        fill_in :registration_user_name, with: "Responsible Citizen"
        fill_in :registration_user_nickname, with: "responsible"
        fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"
        select "City", from: :registration_user_living_area
        select translated(city_residential_area.name), from: :registration_user_city_residential_area
        select translated(city_work_area.name), from: :registration_user_city_work_area
        select "Other", from: :registration_user_gender
        select "September", from: :registration_user_month
        select "1992", from: :registration_user_year

        check :registration_user_tos_agreement
        check :registration_user_additional_tos
        # check :registration_user_newsletter

        find("*[type=submit]").click
      end

      expect(page).to have_content("A message with a code has been sent")
    end

    context "and use_confirmation_codes is disabled" do
      before do
        allow(Decidim::FriendlySignup).to receive(:use_confirmation_codes).and_return(false)
      end

      it "creates a new User" do
        find(".sign-up-link").click

        within ".new_user" do
          fill_in :registration_user_email, with: "user@example.org"
          fill_in :registration_user_name, with: "Responsible Citizen"
          fill_in :registration_user_nickname, with: "responsible"
          fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"
          select "City", from: :registration_user_living_area
          select translated(city_residential_area.name), from: :registration_user_city_residential_area
          select translated(city_work_area.name), from: :registration_user_city_work_area
          select "Other", from: :registration_user_gender
          select "September", from: :registration_user_month
          select "1992", from: :registration_user_year

          check :registration_user_tos_agreement
          check :registration_user_additional_tos
          # check :registration_user_newsletter

          find("*[type=submit]").click
        end

        expect(page).to have_content("confirmation link")
      end
    end
  end

  context "when override_passwords is not active" do
    before do
      allow(Decidim::FriendlySignup).to receive(:override_passwords).and_return(false)
      visit decidim.new_user_registration_path
    end

    it "shows password confirmation" do
      expect(page).to have_content("Sign up to participate")
      expect(page).to have_field("registration_user_name", with: "")
      expect(page).to have_field("registration_user_nickname", with: "")
      expect(page).to have_field("registration_user_email", with: "")
      expect(page).to have_field("registration_user_password", with: "")
      expect(page).to have_field("registration_user_password_confirmation", with: "")
      expect(page).not_to have_field("registration_user_newsletter", checked: false)
    end

    it "creates a new User" do
      find(".sign-up-link").click

      within ".new_user" do
        fill_in :registration_user_email, with: "user@example.org"
        fill_in :registration_user_name, with: "Responsible Citizen"
        fill_in :registration_user_nickname, with: "responsible"
        fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"
        select "City", from: :registration_user_living_area
        select translated(city_residential_area.name), from: :registration_user_city_residential_area
        select translated(city_work_area.name), from: :registration_user_city_work_area
        select "Other", from: :registration_user_gender
        select "September", from: :registration_user_month
        select "1992", from: :registration_user_year

        fill_in :registration_user_password_confirmation, with: "nonsense"
        check :registration_user_tos_agreement
        check :registration_user_additional_tos
        # check :registration_user_newsletter
        find("*[type=submit]").click

        expect(page).to have_content("doesn't match Password")

        fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"

        fill_in :registration_user_password_confirmation, with: "DfyvHn425mYAy2HL"
        find("*[type=submit]").click
      end

      expect(page).to have_content("A message with a code has been sent")
    end

    context "and use_confirmation_codes is disabled" do
      before do
        allow(Decidim::FriendlySignup).to receive(:use_confirmation_codes).and_return(false)
      end

      it "creates a new User" do
        find(".sign-up-link").click

        within ".new_user" do
          fill_in :registration_user_email, with: "user@example.org"
          fill_in :registration_user_name, with: "Responsible Citizen"
          fill_in :registration_user_nickname, with: "responsible"
          fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"
          select "City", from: :registration_user_living_area
          select translated(city_residential_area.name), from: :registration_user_city_residential_area
          select translated(city_work_area.name), from: :registration_user_city_work_area
          select "Other", from: :registration_user_gender
          select "September", from: :registration_user_month
          select "1992", from: :registration_user_year

          fill_in :registration_user_password_confirmation, with: "DfyvHn425mYAy2HL"
          check :registration_user_tos_agreement
          check :registration_user_additional_tos
          # check :registration_user_newsletter

          find("*[type=submit]").click
        end

        expect(page).to have_content("confirmation link")
      end
    end
  end
end
