# frozen_string_literal: true

namespace :decidim do
  namespace :repair do
    desc "Check for nicknames that doesn't respect valid format and update them, if needed force update with REPAIR_NICKNAME_FORCE=1"
    task nickname: :environment do
      logger = Logger.new($stdout)
      logger.info("Checking all nicknames...")

      updated_user_ids = Decidim::RepairNicknameService.run

      if updated_user_ids.blank?
        logger.info("No users updated")
      else
        logger.info("#{updated_user_ids.count} users updated")
        logger.info("Updated users ID : #{updated_user_ids.join(", ")}")
      end

      logger.info("Operation terminated")
    end

    desc "Check for malformed comments body and repair them if needed"
    task comments: :environment do
      logger = Logger.new($stdout)
      logger.info("Checking all comments...")

      updated_comments_ids = Decidim::RepairCommentsService.run

      if updated_comments_ids.blank?
        logger.info("No comments updated")
      else
        logger.info("#{updated_comments_ids} comments updated")
        logger.info("Updated comments ID : #{updated_comments_ids.join(", ")}")
      end

      logger.info("Operation terminated")
    end

    desc "Add all missing translation for translatable resources"
    task translations: :environment do
      logger = Logger.new($stdout)
      if Decidim.enable_machine_translations
        logger.info("Checking all translatable resources...")

        updated_resources_ids = Decidim::RepairTranslationsService.run(logger: logger)

        if updated_resources_ids.blank?
          logger.info("No resources updated")
        else
          logger.info("#{updated_resources_ids.count} resources enqueue for translation")
          logger.info("Enqueued resources : #{updated_resources_ids.join(", ")}")
        end

        logger.info("Operation terminated")
      else
        logger.warn("Machine translation is not enabled")
      end
    end

    desc 'Replaces "@deprecated_endpoint" in every database columns with the right blob URL'
    task url_in_content: :environment do
      logger = Logger.new($stdout)
      deprecated_hosts = ENV["DEPRECATED_OBJECTSTORE_S3_HOSTS"].to_s.split(",").map(&:strip)

      if deprecated_hosts.blank?
        logger.warn("DEPRECATED_OBJECTSTORE_S3_HOSTS env variable is not set")
      else
        deprecated_hosts.each do |host|
          Decidim::RepairUrlInContentService.run(host, logger)
        end
      end
    end

    desc "Fix birth_date in user extended_data"
    task birth_date: :environment do
      Decidim::User.find_each do |user|
        date_of_birth = user.extended_data&.fetch("date_of_birth", "")
        next if date_of_birth.blank?

        begin
          birth_date = Date.parse(date_of_birth).strftime("%Y-%m-%d")
        rescue ArgumentError
          next
        end
        if date_of_birth != birth_date
          user.extended_data["date_of_birth"] = birth_date
          user.save!
        end
      end
    end

    desc "Fix gender in user extended_data"
    task gender: :environment do
      # If user has extended_data with a gender different than : null, "", "female", "male", "other"
      # then we move the value to empty string and store the previous value
      Decidim::User.find_each do |user|
        gender = user.extended_data&.fetch("gender", "")
        next if gender.blank?
        next if %w(female male other).include?(gender)

        user.extended_data["gender-legacy"] = user.extended_data["gender"]
        user.extended_data["gender"] = ""
        user.save!
      end
    end
  end
end
