# frozen_string_literal: true

shared_examples "on/off registration hide nickname" do
  let!(:user) { create(:user, organization: organization, email: "bot@matrix.org", nickname: "agent_smith") }
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
    allow(Decidim::FriendlySignup).to receive(:use_confirmation_codes).and_return(false)
    visit decidim.new_user_registration_path
  end

  context "when hide_nickname is active" do
    it "does not show nickname" do
      expect(page).not_to have_field("registration_user_nickname")
    end

    it "creates a new User" do
      find(".sign-up-link").click

      within ".new_user" do
        fill_in :registration_user_email, with: "user@example.org"
        fill_in :registration_user_name, with: "Agent Smith"
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
      last_user = Decidim::User.last
      expect(last_user.nickname).to eq("agent_smith_2")
    end

    context "and use_confirmation_codes is disabled" do
      before do
        allow(Decidim::FriendlySignup).to receive(:use_confirmation_codes).and_return(true)
      end

      it "creates a new User" do
        find(".sign-up-link").click

        within ".new_user" do
          fill_in :registration_user_email, with: "user@example.org"
          fill_in :registration_user_name, with: "Agent Smith"
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
        last_user = Decidim::User.last
        expect(last_user.nickname).to eq("agent_smith_2")
      end
    end
  end

  context "when hide_nickname is inactive" do
    before do
      allow(Decidim::FriendlySignup).to receive(:hide_nickname).and_return(false)
      visit decidim.new_user_registration_path
    end

    it "shows nickname" do
      expect(page).to have_field("registration_user_nickname")
    end

    it "does not create a new User if nickname is invalid" do
      find(".sign-up-link").click

      within ".new_user" do
        fill_in :registration_user_email, with: "user@example.org"
        fill_in :registration_user_name, with: "Responsible Citizen"
        fill_in :registration_user_nickname, with: " "
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

      expect(page).not_to have_content("confirmation link")
      expect(page).to have_content("can't be blank, is invalid")

      within ".new_user" do
        fill_in :registration_user_nickname, with: "agent_smith"
        fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"

        select "City", from: :registration_user_living_area
        select translated(city_residential_area.name), from: :registration_user_city_residential_area
        select translated(city_work_area.name), from: :registration_user_city_work_area
        select "Other", from: :registration_user_gender
        select "September", from: :registration_user_month
        select "1992", from: :registration_user_year
        find("*[type=submit]").click
      end

      expect(page).not_to have_content("confirmation link")
      expect(page).to have_content("has already been taken")

      within ".new_user" do
        fill_in :registration_user_nickname, with: "agent_smith_2"
        fill_in :registration_user_password, with: "DfyvHn425mYAy2HL"

        select "City", from: :registration_user_living_area
        select translated(city_residential_area.name), from: :registration_user_city_residential_area
        select translated(city_work_area.name), from: :registration_user_city_work_area
        select "Other", from: :registration_user_gender
        select "September", from: :registration_user_month
        select "1992", from: :registration_user_year
        find("*[type=submit]").click
      end

      expect(page).to have_content("confirmation link")
    end

    context "and use_confirmation_codes enabled" do
      before do
        allow(Decidim::FriendlySignup).to receive(:use_confirmation_codes).and_return(true)
      end

      it "creates a new User" do
        find(".sign-up-link").click

        within ".new_user" do
          fill_in :registration_user_email, with: "agent@example.org"
          fill_in :registration_user_name, with: "Agent Smith"
          fill_in :registration_user_nickname, with: "agent_smith_2"
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
        last_user = Decidim::User.last
        expect(last_user.nickname).to eq("agent_smith_2")
      end
    end
  end
end
