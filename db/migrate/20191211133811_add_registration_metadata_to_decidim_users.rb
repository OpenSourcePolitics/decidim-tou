# frozen_string_literal: true

class AddRegistrationMetadataToDecidimUsers < ActiveRecord::Migration[5.2]
  def change
<<<<<<< HEAD
    add_column :decidim_users, :registration_metadata, :jsonb unless column_exists? :decidim_users, :registration_metadata
=======
    unless column_exists? :decidim_users, :registration_metadata
      add_column :decidim_users, :registration_metadata, :jsonb
    end
>>>>>>> develop
  end
end
