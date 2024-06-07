# frozen_string_literal: true

require "uri"
require "net/http"

module Decidim
  class SmsGatewayService
    attr_reader :mobile_phone_number, :code

    def initialize(mobile_phone_number, code)
      Rails.logger.debug { "#{mobile_phone_number} - #{code}" }

      @mobile_phone_number = mobile_phone_number
      @code = code
      @url = "https://ssl.etoilediese.fr/envoi/sms/envoi.php"
      @username = ENV.fetch("SMS_GATEWAY_USERNAME", nil)
      @password = ENV.fetch("SMS_GATEWAY_PASSWORD", nil)
      @message = sms_message
      @type = "sms"
    end

    def deliver_code
      url = URI("#{@url}?u=#{@username}&p=#{@password}&t=#{@message}&n=#{@mobile_phone_number}&f=#{@type}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      https.request(request)

      true
    end

    # Ensure '@code' is not a full i18n keys rather than a verification code.
    def sms_message
      return code if code.to_s.length > Decidim::HalfSignup.auth_code_length

      I18n.t("sms_verification_workflow.message", code: code)
    end
  end
end
