# frozen_string_literal: true

Decidim::Verifications.register_workflow(:osp_authorization_handler) do |auth|
  auth.form = "Decidim::OspAuthorizationHandler"
end

Rails.application.initializer "sms_verification_workflow", after: "decidim.sms_verification_workflow" do
  Decidim::Verifications.find_workflow_manifest(:sms).expires_in = 5.minutes if Decidim.sms_gateway_service
end
