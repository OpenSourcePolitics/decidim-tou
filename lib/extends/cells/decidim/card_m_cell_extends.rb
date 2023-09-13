# frozen_string_literal: true

module Decidim
  module CardMCellExtends
    def has_data?
      return if model.respond_to?("data?") && model.data?

      false unless context[:data].presence
    end
  end
end

Decidim::CardMCell.class_eval do
  prepend(Decidim::CardMCellExtends)
end
