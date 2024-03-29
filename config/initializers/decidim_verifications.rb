# frozen_string_literal: true

# Decidim::Verifications.register_workflow(:dummy_authorization_handler) do |workflow|
#   workflow.form = "DummyAuthorizationHandler"
#   workflow.action_authorizer = "DummyAuthorizationHandler::ActionAuthorizer"
#   workflow.expires_in = 1.hour
#
#   workflow.options do |options|
#     options.attribute :postal_code, type: :string, default: "08001", required: false
#   end
# end
#
# Decidim::Verifications.register_workflow(:another_dummy_authorization_handler) do |workflow|
#   workflow.form = "AnotherDummyAuthorizationHandler"
#   workflow.expires_in = 1.hour
#
#   workflow.options do |options|
#     options.attribute :passport_number, type: :string, required: false
#   end
# end

Decidim::Verifications.register_workflow(:osp_authorization_handler) do |auth|
  auth.form = "Decidim::OspAuthorizationHandler"
end

Rails.application.initializer "sms_verification_workflow", after: "decidim.sms_verification_workflow" do
  Decidim::Verifications.find_workflow_manifest(:sms).expires_in = 5.minutes if Decidim.sms_gateway_service
end
