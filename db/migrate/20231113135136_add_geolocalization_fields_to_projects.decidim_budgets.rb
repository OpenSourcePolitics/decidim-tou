# frozen_string_literal: true
# This migration comes from decidim_budgets (originally 20220428072638)

class AddGeolocalizationFieldsToProjects < ActiveRecord::Migration[6.1]
  def up
    unless column_exists?(:decidim_budgets_projects, :address)
      add_column :decidim_budgets_projects, :address, :text, if_not_exists: true
      add_column :decidim_budgets_projects, :latitude, :float, if_not_exists: true
      add_column :decidim_budgets_projects, :longitude, :float, if_not_exists: true
    end
  end
end
