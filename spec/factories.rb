# frozen_string_literal: true

require "decidim/core/test/factories"
require "decidim/proposals/test/factories"
require "decidim/debates/test/factories"
require "decidim/meetings/test/factories"
require "decidim/accountability/test/factories"
require "decidim/system/test/factories"
require "decidim/participatory_processes/test/factories"

FactoryBot.modify do
  factory :debate, class: "Decidim::Debates::Debate" do
    title { generate_localized_debate_title }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_debate_title } }
    information_updates { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_debate_title } }
    instructions { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_debate_title } }
    start_time { 1.day.from_now }
    end_time { start_time.advance(hours: 2) }
    component { build(:component, manifest_name: "debates") }
    author { component.try(:organization) }

    trait :open_ama do
      start_time { 1.day.ago }
      end_time { 1.day.from_now }
    end

    trait :with_author do
      author do
        build(:user, organization: component.organization) if component
      end
    end

    trait :with_user_group_author do
      author do
        create(:user, organization: component.organization) if component
      end
      user_group do
        create(:user_group, :verified, organization: component.organization, users: [author]) if component
      end
    end
  end

  factory :participatory_process, class: "Decidim::ParticipatoryProcess" do
    title { generate_localized_title }
    slug { generate(:participatory_process_slug) }
    subtitle { generate_localized_title }
    short_description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_title } }
    description { Decidim::Faker::Localized.wrapped("<p>", "</p>") { generate_localized_title } }
    organization
    hero_image { Decidim::Dev.test_file("city.jpeg", "image/jpeg") } # Keep after organization
    banner_image { Decidim::Dev.test_file("city2.jpeg", "image/jpeg") } # Keep after organization
    published_at { Time.current }
    meta_scope { Decidim::Faker::Localized.word }
    developer_group { generate_localized_title }
    local_area { generate_localized_title }
    target { generate_localized_title }
    participatory_scope { generate_localized_title }
    participatory_structure { generate_localized_title }
    announcement { generate_localized_title }
    show_metrics { true }
    show_statistics { true }
    private_space { false }
    start_date { Date.current }
    end_date { 2.months.from_now }
    area { nil }
    display_linked_assemblies { false }

    trait :with_linked_assemblies do
      display_linked_assemblies { true }
    end

    trait :promoted do
      promoted { true }
    end

    trait :unpublished do
      published_at { nil }
    end

    trait :published do
      published_at { Time.current }
    end

    trait :private do
      private_space { true }
    end

    trait :with_steps do
      transient { current_step_ends { 1.month.from_now } }

      after(:create) do |participatory_process, evaluator|
        create(:participatory_process_step,
               active: true,
               end_date: evaluator.current_step_ends,
               participatory_process: participatory_process)
        participatory_process.reload
        participatory_process.steps.reload
      end
    end

    trait :active do
      start_date { 2.weeks.ago }
      end_date { 1.week.from_now }
    end

    trait :past do
      start_date { 2.weeks.ago }
      end_date { 1.week.ago }
    end

    trait :upcoming do
      start_date { 1.week.from_now }
      end_date { 2.weeks.from_now }
    end

    trait :with_scope do
      scopes_enabled { true }
      scope { create :scope, organization: organization }
    end
  end
end
