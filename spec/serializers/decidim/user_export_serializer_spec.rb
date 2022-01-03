# frozen_string_literal: true

require "spec_helper"

module Decidim
  module UserExporter
    describe UserExportSerializer do
      let(:subject) { described_class.new(resource) }
      let!(:organization) { create(:organization) }
      let(:resource) { create(:user, organization: organization, registration_metadata: registration_metadata) }
      let!(:city_work_area) { create(:scope, organization: organization) }
      let!(:city_residential_area) { create(:scope, organization: organization) }
      let!(:living_area) { "city" }
      let(:registration_metadata) do
        {
          living_area: living_area,
          city_residential_area: city_residential_area.id,
          city_work_area: city_work_area.id,
          gender: "other",
          birth_date: { month: "June", year: "1990" },
          statutory_representative_email: generate(:email)
        }
      end
      let(:serialized) { subject.serialize }

      describe "#serialize" do
        it "includes the id" do
          expect(serialized).to include(id: resource.id)
        end

        it "includes the email" do
          expect(serialized).to include(email: resource.email)
        end

        it "includes the name" do
          expect(serialized).to include(name: resource.name)
        end

        it "includes the nickname" do
          expect(serialized).to include(nickname: resource.nickname)
        end

        it "doesn't includes the locale" do
          expect(serialized).not_to include(locale: resource.locale)
        end

        it "includes the organization" do
          expect(serialized[:organization]).to(
            include(id: resource.organization.id)
          )
          expect(serialized[:organization]).to(
            include(name: resource.organization.name)
          )
        end

        it "doesn't includes the newsletter notifications" do
          expect(serialized).not_to include(newsletter_notifications_at: resource.newsletter_notifications_at)
        end

        it "doesn't includes the email on notification" do
          expect(serialized).not_to include(email_on_notification: resource.email_on_notification)
        end

        it "includes the admin" do
          expect(serialized).to include(admin: resource.admin)
        end

        it "doesn't includes the personal url" do
          expect(serialized).not_to include(personal_url: resource.personal_url)
        end

        it "doesn't includes the about" do
          expect(serialized).not_to include(about: resource.about)
        end

        it "includes the invitation created at" do
          expect(serialized).to include(invitation_created_at: resource.invitation_created_at)
        end

        it "includes the invitation sent at" do
          expect(serialized).to include(invitation_sent_at: resource.invitation_sent_at)
        end

        it "includes the invitation accepted at" do
          expect(serialized).to include(invitation_accepted_at: resource.invitation_accepted_at)
        end

        it "includes the invited_by" do
          expect(serialized[:invited_by]).to(
            include(id: resource.invited_by_id)
          )
          expect(serialized[:invited_by]).to(
            include(type: resource.invited_by_type)
          )
        end

        it "includes the invitations count" do
          expect(serialized).to include(invitations_count: resource.invitations_count)
        end

        it "doesn't includes the reset password sent at" do
          expect(serialized).not_to include(reset_password_sent_at: resource.reset_password_sent_at)
        end

        it "doesn't includes the remember created at" do
          expect(serialized).not_to include(remember_created_at: resource.remember_created_at)
        end

        it "includes the sign in count" do
          expect(serialized).to include(sign_in_count: resource.sign_in_count)
        end

        it "doesn't includes the current sign in at" do
          expect(serialized).not_to include(current_sign_in_at: resource.current_sign_in_at)
        end

        it "includes the last sign in at" do
          expect(serialized).to include(last_sign_in_at: resource.last_sign_in_at)
        end

        it "doesn't includes the current sign in ip" do
          expect(serialized).not_to include(current_sign_in_ip: resource.current_sign_in_ip)
        end

        it "doesn't includes the last sign in ip" do
          expect(serialized).not_to include(last_sign_in_ip: resource.last_sign_in_ip)
        end

        it "includes the created at" do
          expect(serialized).to include(created_at: resource.created_at)
        end

        it "includes the updated at" do
          expect(serialized).to include(updated_at: resource.updated_at)
        end

        it "includes the confirmed at" do
          expect(serialized).to include(confirmed_at: resource.confirmed_at)
        end

        it "doesn't includes the confirmation sent at" do
          expect(serialized).not_to include(confirmation_sent_at: resource.confirmation_sent_at)
        end

        it "includes the unconfirmed email" do
          expect(serialized).to include(unconfirmed_email: resource.unconfirmed_email)
        end

        it "includes the delete reason" do
          expect(serialized).to include(delete_reason: resource.delete_reason)
        end

        it "includes the deleted at" do
          expect(serialized).to include(deleted_at: resource.deleted_at)
        end

        it "includes the managed" do
          expect(serialized).to include(managed: resource.managed)
        end

        it "includes the officialized at" do
          expect(serialized).to include(officialized_at: resource.officialized_at)
        end

        it "includes the officialized as" do
          expect(serialized).to include(officialized_as: resource.officialized_as)
        end

        it "includes tos accepted version" do
          expect(serialized).to include(accepted_tos_version: resource.accepted_tos_version)
        end

        it "includes age scope" do
          expect(serialized).to include(:age_scope)
        end

        context "when export_user_fields is defined" do
          it "exports fields from registration metadata" do
            expect(serialized).to include(living_area: "city")
            expect(serialized).to include(city_work_area: translated(Decidim::Scope.find(resource.registration_metadata["city_work_area"]).name))
            expect(serialized).to include(city_residential_area: translated(Decidim::Scope.find(resource.registration_metadata["city_residential_area"]).name))
            expect(serialized).to include(metropolis_work_area: "")
            expect(serialized).to include(metropolis_residential_area: "")
            expect(serialized).to include(gender: "other")
            expect(serialized).to include(:birth_date)
            expect(serialized).to include(statutory_representative_email: resource.registration_metadata["statutory_representative_email"])
          end

          context "when extended data is nil" do
            let(:resource) { create(:user, registration_metadata: nil) }

            it "exports fields from extended data" do
              expect(serialized).to include(living_area: "")
              expect(serialized).to include(city_work_area: "")
              expect(serialized).to include(city_residential_area: "")
              expect(serialized).to include(metropolis_work_area: "")
              expect(serialized).to include(metropolis_residential_area: "")
              expect(serialized).to include(birth_date: "")
              expect(serialized).to include(statutory_representative_email: "")
            end
          end
        end
      end
    end
  end
end
