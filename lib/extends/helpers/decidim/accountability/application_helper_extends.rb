# frozen_string_literal: true

module Decidim
  module Accountability
    module ApplicationHelperExtends
      def sorted_subscopes
        @sorted_subscopes ||= current_participatory_space.subscopes.sort_by { |subscope| subscope.name.values.first.split.first }
      end
    end
  end
end

Decidim::Accountability::ApplicationHelper.module_eval do
  prepend(Decidim::Accountability::ApplicationHelperExtends)
end
