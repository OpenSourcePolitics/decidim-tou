# frozen_string_literal: true

class CastScopeIdRegistrationMetadata < ActiveRecord::Migration[5.2]
  def up
    Rails.logger = Logger.new($stdout)
    Rails.logger.debug "Updating scope ID in users registration metadata"

    users = fetch_users
    return if users.blank?

    Rails.logger.debug "Retrieving a list of #{users.count} users"
    users.each do |user|
      registration_metadata = user.registration_metadata
      %w(city_work_area city_residential_area metropolis_residential_area metropolis_work_area).each do |scope_key|
        scope_id = registration_metadata.fetch(scope_key, nil)
        next if scope_id.blank?

        registration_metadata[scope_key] = cast_scope_id_to_name(scope_id)
      end

      user.update_column(:registration_metadata, registration_metadata)
      Rails.logger.debug "User ID #{user.id} updated"
    end
  end

  def fetch_users
    Decidim::User.where("(registration_metadata->'city_work_area') is not null")
                 .or(Decidim::User.where("(registration_metadata->'city_residential_area') is not null"))
                 .or(Decidim::User.where("(registration_metadata->'metropolis_residential_area') is not null"))
                 .or(Decidim::User.where("(registration_metadata->'metropolis_work_area') is not null"))
  end

  def cast_scope_id_to_name(scope_id)
    # Ensure scope_id only contains numeric chars
    return scope_id unless scope_id !~ /\D/

    scope = Decidim::Scope.find(scope_id)
    # If scope is blank or parent undefined, then it isn't a registration form scope.
    return scope_id if scope.blank? || scope.try(:parent).blank?

    scope.name[Decidim.default_locale.to_s]
  rescue StandardError
    # Better to return initial value to prevent migration fail
    scope_id
  end
end
