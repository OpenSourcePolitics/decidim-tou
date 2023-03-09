# frozen_string_literal: true

module Decidim
  module Meetings
    module Directory
      module ApplicationHelperExtends
        include Decidim::CheckBoxesTreeHelper
        def scope_children_to_tree(scope)
          return unless scope.children.any?

          sorted_children = sort_children(scope.children)

          sorted_children.flat_map do |child|
            TreeNode.new(
              TreePoint.new(child.id.to_s, translated_attribute(child.name, current_organization)),
              scope_children_to_tree(child)
            )
          end
        end

        def sort_children(children)
          children.sort_by { |child| child.name.values.first.split.first }
        end
      end
    end
  end
end

Decidim::Meetings::Directory::ApplicationHelper.module_eval do
  prepend(Decidim::Meetings::Directory::ApplicationHelperExtends)
end
