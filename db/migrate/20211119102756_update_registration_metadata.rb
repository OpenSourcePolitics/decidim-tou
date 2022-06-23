# frozen_string_literal: true

class UpdateRegistrationMetadata < ActiveRecord::Migration[5.2]
  # Fetch all users with registration_metadata completed
  #
  # If work_area and residential_area are defined
  #   Copy work_area and residential_area in new field city_work_area and city_residential_area
  # elsif city_work_area and city_residential_area are defined
  #   Copy city_work_area and city_residential_area in new field work_area and residential_area
  #
  # The aim of this migration is to copy data. It shouldn't remove any data in registration_metadata field.
  def up
    Rails.logger = Logger.new($stdout)
    old_users = fetch_old_users
    new_users = fetch_new_users

    update_metadata_for(old_users, :old) do |user|
      registration_metadata = user.registration_metadata
      registration_metadata["city_work_area"] = registration_metadata["work_area"]
      registration_metadata["city_residential_area"] = registration_metadata["residential_area"]
      registration_metadata["metropolis_work_area"] = nil
      registration_metadata["metropolis_residential_area"] = nil

      user.update_column(:registration_metadata, registration_metadata)
    end

    update_metadata_for(new_users, :new) do |user|
      registration_metadata = user.registration_metadata
      registration_metadata["work_area"] = registration_metadata["city_work_area"]
      registration_metadata["residential_area"] = registration_metadata["city_residential_area"]

      user.update_column(:registration_metadata, registration_metadata)
    end
  end

  def fetch_old_users
    Decidim::User.where("(registration_metadata->'work_area') is not null")
                 .where("(registration_metadata->'residential_area') is not null")
                 .where("(
registration_metadata->'city_work_area') is null")
                 .where("(registration_metadata->'city_residential_area') is null")
  end

  def fetch_new_users
    Decidim::User.where("(registration_metadata->'city_work_area') is not null")
                 .where("(registration_metadata->'city_residential_area') is not null")
                 .where("(
registration_metadata->'work_area') is null")
                 .where("(registration_metadata->'residential_area') is null")
  end

  def update_metadata_for(users, seniority)
    return if users.blank?

    Rails.logger.debug "Updating #{users.count} #{seniority} users..."

    users.each do |user|
      yield(user)

      Rails.logger.debug "User ID: #{user.id} updated"
    end
  end
end
