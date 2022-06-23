# frozen_string_literal: true

class CleanScopesIdsInRegistrationMetadata < ActiveRecord::Migration[5.2]
  def up
    mirror_logger = Logger.new($stdout)
    Rails.logger.debug "Updating scope ID in users registration metadata"
    mirror_logger.debug "Updating scope ID in users registration metadata"

    users = fetch_users
    return if users.blank?

    Rails.logger.debug "Retrieving a list of #{users.count} users"
    mirror_logger.debug "Retrieving a list of #{users.count} users"

    users.each do |user|
      registration_metadata = user.try(:registration_metadata) || {}

      %w(city_work_area city_residential_area metropolis_residential_area metropolis_work_area work_area residential_area).each do |scope_key|
        registration_metadata[scope_key] = registration_metadata.fetch(scope_key, "") || ""

        # If scope key is defined
        if registration_metadata[scope_key].present?

          # And it only contains numbers
          if registration_metadata[scope_key] !~ /\D/
            # Cast to to integer before storing in DB
            registration_metadata[scope_key] = registration_metadata[scope_key].to_i
          else
            # If it contains letters, maybe it is a scope name
            # We check for a name called like this
            scope = Decidim::Scope.find_by(name: { "fr": registration_metadata[scope_key] })

            if scope.present? && scope.is_a?(Decidim::Scope)
              # Replace scope name by scope title if scope is defined
              registration_metadata[scope_key] = scope.id
            end
          end
        end
      end

      user.update_column(:registration_metadata, registration_metadata)
      Rails.logger.debug "User ID #{user.id} updated"
      mirror_logger.debug "User ID #{user.id} updated"
    end
  end

  def fetch_users
    Decidim::User.all
  end
end
