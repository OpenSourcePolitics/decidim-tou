# frozen_string_literal: true

module CreateRegistrationExtend
  def create_user
    @user = Decidim::User.create!(
      email: form.email,
      name: form.name,
      nickname: form.nickname,
      password: form.password,
      password_confirmation: form.password_confirmation,
      organization: form.current_organization,
      tos_agreement: form.tos_agreement,
      newsletter_notifications_at: form.newsletter_at,
      email_on_notification: true,
      accepted_tos_version: form.current_organization.tos_version,
      locale: form.current_locale,
      registration_metadata: registration_metadata
    )
  end

  def registration_metadata
    {
      living_area: form.try(:living_area),
      city_residential_area: city_living_area? ? form.try(:city_residential_area) : nil,
      city_work_area: city_living_area? ? form.try(:city_work_area) : nil,
      metropolis_residential_area: metropolis_living_area? ? form.try(:metropolis_residential_area) : nil,
      metropolis_work_area: metropolis_living_area? ? form.try(:metropolis_work_area) : nil
    }
  end

  private

  def city_living_area?
    form.try(:living_area) == "city"
  end

  def metropolis_living_area?
    form.try(:living_area) == "metropolis"
  end
end

Decidim::CreateRegistration.class_eval do
  prepend(CreateRegistrationExtend)
end
