# frozen_string_literal: true

require "active_support/concern"

module UserModelExtend
  extend ActiveSupport::Concern

  included do
    # Fetch areas in registration metadata
    def fetch_registration_area(kind)
      scope_id = registration_metadata.fetch(kind.to_s, "")

      return "" unless scope_id.present? && scope_id.is_a?(Integer)

      Decidim::Scope.find(scope_id).name[Decidim.default_locale.to_s].presence || ""
    rescue StandardError
      ""
    end
  end
end