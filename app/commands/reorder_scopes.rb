# frozen_string_literal: true

class ReorderScopes < Decidim::Command
  def initialize(organization, scope, ids)
    @organization = organization
    @scope = scope
    @ids = ids
  end

  def call
    return broadcast(:invalid) if @ids.blank?

    reorder_scopes
    broadcast(:ok)
  end

  def collection
    @collection ||= Decidim::Scope.where(id: @ids, organization: @organization)
  end

  def reorder_scopes
    transaction do
      reset_weights
      collection.reload
      set_new_weights
    end
  end

  def reset_weights
    # rubocop:disable Rails/SkipsModelValidations
    collection.where.not(weight: nil).update_all(weight: nil)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def set_new_weights
    data = @ids.each_with_index.inject({}) do |hash, (id, index)|
      hash.update(id => index + 1)
    end

    data.each do |id, weight|
      scope = collection.find { |block| block.id == id.to_i }
      scope.update!(weight: weight) if scope.present?
    end
  end
end
