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
end

