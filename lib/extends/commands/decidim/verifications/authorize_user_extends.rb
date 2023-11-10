# frozen_string_literal: true

module AuthorizeUserExtends
  extend ActiveSupport::Concern

  included do
    # Override commands to remove the verification conflict
    def call
      return broadcast(:invalid) if handler.invalid?

      Decidim::Authorization.create_or_update_from(handler)

      broadcast(:ok)
    end
  end
end

Decidim::Verifications::AuthorizeUser.class_eval do
  include(AuthorizeUserExtends)
end
