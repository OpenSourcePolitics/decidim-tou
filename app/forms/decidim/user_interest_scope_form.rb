# frozen_string_literal: true

module Decidim
  # The form object that handles the data behind updating a user's
  # interests in her profile page.
  class UserInterestScopeForm < Form
    mimic :scope

    attribute :name, String
    attribute :checked, Boolean
    attribute :children, Array[UserInterestScopeForm]

    def map_model(model_hash)
      scope = model_hash[:scope]
      user = model_hash[:user]

      self.id = scope.id
      self.name = scope.name
      self.checked = user.interested_scopes_ids.include?(scope.id)
      self.children = scope.children
                           .sort_by { |children_scope| children_scope.name[I18n.locale.to_s] }
                           .map { |children_scope| UserInterestScopeForm.from_model(scope: children_scope, user: user) }
    end
  end
end
