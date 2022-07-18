# frozen_string_literal: true

class AddRegistrationMetadataToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_users, :registration_metadata, :jsonb unless column_exists? :decidim_users, :registration_metadata
  end
end
