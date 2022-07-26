# frozen_string_literal: true

require "spec_helper"

describe "Account", type: :system do
  let(:user) { create(:user, :confirmed, password: password, password_confirmation: password) }
  let(:password) { "dqCFgjfDbC7dPbrv" }
  let(:organization) { user.organization }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  describe "navigation" do
    it "shows the account form when clicking on the menu" do
      visit decidim.root_path

      within ".topbar__user__logged" do
        find("a", text: user.name).click
        find("a", text: "My account").click
      end

      expect(page).to have_css("form.edit_user")
    end
  end

  context "when on the account page" do
    before do
      visit decidim.account_path
    end

    it_behaves_like "accessible page"

    describe "update avatar" do
      it "cannot update avatar" do
        expect(page).not_to have_content("avatar")
      end
    end

    describe "update locales" do
      context "when the organization has one locale" do
        let(:organization) { create(:organization, available_locales: ["en"]) }

        it "is not possible to change locales, #user_locale is disabled" do
          expect(page).to have_css("#user_locale", text: "English")
          expect(find("#user_locale")).to be_disabled
        end
      end

      context "when the organization has more than one locale" do
        it "shows the list of locales" do
          find("#user_locale").click
          expect(page).to have_css("option", count: organization.available_locales.size)
        end
      end
    end

    describe "updating personal data" do
      it "updates the user's data" do
        within "form.edit_user" do
          fill_in :user_name, with: "Nikola Tesla"
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("successfully")
        end

        within ".title-bar" do
          expect(page).to have_content("Nikola Tesla")
        end
      end
    end

    describe "updating locale" do
      context "when the organization has more than one locale" do
        it "switches the locale to french" do
          within "form.edit_user" do
            find("#user_locale").click
            find("option", text: "Français").select_option
            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("successfully")
          end

          within "#user_locale" do
            expect(page).to have_content("Français")
          end
          expect(page).to have_css(".help-text", text: organization.name)
        end
      end
    end

    describe "updating the password" do
      context "when password and confirmation match" do
        it "updates the password successfully" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "sekritpass123"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("successfully")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(true)
        end
      end

      context "when passwords don't match" do
        it "doesn't update the password" do
          within "form.edit_user" do
            page.find(".change-password").click

            fill_in :user_password, with: "sekritpass123"
            fill_in :user_password_confirmation, with: "oopseytypo"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("There was a problem")
          end

          expect(user.reload.valid_password?("sekritpass123")).to eq(false)
        end
      end

      context "when updating the email" do
        it "needs to confirm it" do
          within "form.edit_user" do
            fill_in :user_email, with: "foo@bar.com"

            find("*[type=submit]").click
          end

          within_flash_messages do
            expect(page).to have_content("email to confirm")
          end
        end
      end
    end

    context "when on the notifications settings page" do
      before do
        visit decidim.notifications_settings_path
      end

      it "updates the user's notifications" do
        within ".switch.newsletter_notifications" do
          page.find(".switch-paddle").click
        end

        within "form.edit_user" do
          find("*[type=submit]").click
        end

        within_flash_messages do
          expect(page).to have_content("successfully")
        end
      end
    end

    context "when on the delete my account page" do
      before do
        visit decidim.delete_account_path
      end

      it "the user can delete his account" do
        fill_in :delete_user_delete_account_delete_reason, with: "I just want to delete my account"

        click_button "Delete my account"

        click_button "Yes, I want to delete my account"

        within_flash_messages do
          expect(page).to have_content("successfully")
        end

        find(".sign-in-link").click

        within ".new_user" do
          fill_in :session_user_email, with: user.email
          fill_in :session_user_password, with: password
          find("*[type=submit]").click
        end

        expect(page).to have_no_content("Signed in successfully")
        expect(page).to have_no_content(user.name)
      end
    end
  end
end
