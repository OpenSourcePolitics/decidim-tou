# frozen_string_literal: true

%w(
  core
  proposals
  budgets
  debates
  meetings
  accountability
  system
  participatory_processes
  verifications
  surveys
).each { |f| require "decidim/#{f}/test/factories" }

FactoryBot.modify do
  factory :user, class: "Decidim::User" do
    email { generate(:email) }
    password { "password123456" }
    password_confirmation { password }
    name { generate(:name) }
    nickname { generate(:nickname) }
    organization
    locale { organization.default_locale }
    tos_agreement { "1" }
    avatar { Decidim::Dev.test_file("avatar.jpg", "image/jpeg") }
    personal_url { Faker::Internet.url }
    about { "<script>alert(\"ABOUT\");</script>#{Faker::Lorem.paragraph(sentence_count: 2)}" }
    confirmation_sent_at { Time.current }
    accepted_tos_version { organization.tos_version }
    email_on_notification { true }
    registration_metadata do
      {
        city_residential_area: build(:scope).id.to_s,
        city_work_area: build(:scope).id.to_s,
        gender: "other",
        birth_date: { month: Faker::Date.birthday.month, year: Faker::Date.birthday.year },
        statutory_representative_email: generate(:email)
      }
    end

    trait :confirmed do
      confirmed_at { Time.current }
    end

    trait :deleted do
      email { "" }
      deleted_at { Time.current }
    end

    trait :admin_terms_accepted do
      admin_terms_accepted_at { Time.current }
    end

    trait :admin do
      admin { true }
      admin_terms_accepted
    end

    trait :user_manager do
      roles { ["user_manager"] }
      admin_terms_accepted
    end

    trait :managed do
      email { "" }
      password { "" }
      password_confirmation { "" }
      encrypted_password { "" }
      managed { true }
    end

    trait :officialized do
      officialized_at { Time.current }
      officialized_as { generate_localized_title }
    end
  end
end
