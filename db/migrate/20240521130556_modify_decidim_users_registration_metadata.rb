class ModifyDecidimUsersRegistrationMetadata < ActiveRecord::Migration[6.1]
  REGISTRATION_METADATA_BIRTH_DATE = "birth_date"
  REGISTRATION_METADATA_GENDER = "gender"
  EXTENDED_DATA_BIRTH_DATE = "date_of_birth"
  EXTENDED_DATA_GENDER = "gender"
  DAY_OF_BIRTH = "01"

  # This migration modifies the extended_data of the users
  # It copies birth_date and gender from registration_metadata to extended_data
  # This migration don't destroy any data
  # If the user has already the extended_data keys, it will not be modified
  # If the user has extended_data modified, a key migrated_at is added in json
  # example:
  # registration_metadata = {"gender"=>"female", "birth_date"=>{"year"=>"1973", "month"=>"March"}}
  # extended_data = {"gender"=>"female", "date_of_birth"=>"1973-03-01", "migrated_at"=>"2024-05-21 16:07:29 +0200"}
  def up
    Decidim::User.find_each do |user|
      registration_metadata = user.registration_metadata || {}
      extended_data = {}
      extended_data.merge!(gender(registration_metadata, user.extended_data))
      extended_data.merge!(birth_date(registration_metadata, user.extended_data))

      if user.extended_data != extended_data
        user.extended_data = extended_data
        user.extended_data.merge!("migrated_at" => Time.zone.now.to_s)

        user.save!
      end
    end
  end

  private

  def gender(source, extended_data)
    return {} if source.blank?
    return {} if source.fetch(REGISTRATION_METADATA_GENDER, nil).blank?
    return {} if extended_data&.fetch(EXTENDED_DATA_GENDER, nil).present?

    { REGISTRATION_METADATA_GENDER => source.fetch(EXTENDED_DATA_GENDER) }
  end

  def birth_date(source, extended_data)
    return {} if source.blank?
    return {} if source.fetch(REGISTRATION_METADATA_BIRTH_DATE, nil).blank?
    return {} if extended_data&.fetch(EXTENDED_DATA_BIRTH_DATE, nil).present?

    birth_year = source.dig(REGISTRATION_METADATA_BIRTH_DATE, "year").presence || Time.zone.now.year
    birth_month = source.dig(REGISTRATION_METADATA_BIRTH_DATE, "month").presence || Time.zone.now.month
    birth_date = "#{birth_year}-#{birth_month}-#{DAY_OF_BIRTH}"

    { EXTENDED_DATA_BIRTH_DATE => birth_date }
  end
end
