# frozen_string_literal: true

module Decidim
  module Meetings
    module Directory
      module ApplicationHelperExtends
        include Decidim::CheckBoxesTreeHelper
        def scope_children_to_tree(scope)
          return unless scope.children.any?

          sorted_children = scope.children.sort_by { |subscope| subscope.name[I18n.locale.to_s] || subscope.name[I18n.default_locale] }
          sorted_children.flat_map do |child|
            TreeNode.new(
              TreePoint.new(child.id.to_s, translated_attribute(child.name, current_organization)),
              scope_children_to_tree(child)
            )
          end
        end
      end
    end
  end
end

Decidim::Meetings::Directory::ApplicationHelper.module_eval do
  prepend(Decidim::Meetings::Directory::ApplicationHelperExtends)
end
