# frozen_string_literal: true

namespace :decidim do
  namespace :repare do
    desc "Check for nicknames that doesn't respect valid format and update them"
    task nickname: :environment do
      logger = Logger.new("log/repare-nicknames-#{Time.zone.now.strftime("%Y-%m-%d-%H-%M-%S")}.log")
      logger.info("[data:repare:nickname] :: Checking all nicknames...")
      invalid_users = Decidim::User.where.not("nickname ~* ?", "^[\\w-]+$")

      if invalid_users.blank?
        logger.info("[data:repare:nickname] :: All nicknames seems to be valid")
        logger.info("[data:repare:nickname] :: Operation terminated")
      end

      logger.info("[data:repare:nickname] :: Found #{invalid_users.count} invalids nicknames")
      logger.info("[data:repare:nickname] :: Invalid user IDs : [#{invalid_users.map(&:id).join(", ")}]")

      updated_users = []
      invalid_users.each do |user|
        chars = []

        user.nickname.codepoints.each do |ascii_code|
          char = ascii_to_valid_char(ascii_code)
          chars << char if char.present?
        end

        new_nickname = deduplicate_new_nickname(user, chars.join.downcase)
        logger.info("[data:repare:nickname] :: User (##{user.id}) renaming nickname from '#{user.nickname}' to '#{new_nickname}'")
        user.nickname = new_nickname

        updated_users << user
      end

      if ENV["FORCE_NICKNAME_UPDATE"].present?
        logger.info("[data:repare:nickname] :: Updating users...")
        updated_users.each do |user|
          user.save!
          logger.info("[data:repare:nickname] :: User (##{user.id}) successfully updated")
        rescue StandardError => e
          logger.error("[data:repare:nickname] :: User (##{user.id}) an error occured")
          logger.error("[data:repare:nickname] :: #{e}")
        end
      else
        logger.info("[data:repare:nickname] :: Operation terminated")
      end
      logger.close
    end
  end
end

def deduplicate_new_nickname(user, new_nickname)
  user.nickname = new_nickname
  if user.valid?
    new_nickname
  else
    "#{new_nickname}-#{user.id}"
  end
end

def ascii_to_valid_char(id)
  letters = ("A".."Z").to_a.join("").codepoints
  letters += ("a".."z").to_a.join("").codepoints
  digits = ("0".."9").to_a.join("").codepoints
  special_chars = %w(- _).join("").codepoints

  valid_ascii_code = letters + digits + special_chars

  valid_ascii_code.include?(id) ? id.chr : ""
end
