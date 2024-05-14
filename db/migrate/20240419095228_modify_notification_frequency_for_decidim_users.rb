class ModifyNotificationFrequencyForDecidimUsers < ActiveRecord::Migration[6.1]
  def up
    users = Decidim::User.where.not(notifications_sending_frequency: "none")
    return if users.blank?

    Rails.logger.info("Updating #{users.count} users to none frequency")
    users.update_all(notifications_sending_frequency: "none")
  end
end
