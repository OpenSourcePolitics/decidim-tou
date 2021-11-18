# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# You can remove the 'faker' gem if you don't want Decidim seeds.
if ENV["HEROKU_APP_NAME"].present?
  ENV["DECIDIM_HOST"] = ENV["HEROKU_APP_NAME"] + ".herokuapp.com"
  ENV["SEED"] = "true"
end

#  factory :scope, class: "Decidim::Scope" do
#     name { Decidim::Faker::Localized.literal(generate(:scope_name)) }
#     code { generate(:scope_code) }
#     scope_type { create(:scope_type, organization: organization) }
#     organization { parent ? parent.organization : build(:organization) }
#   end
Decidim.seed!

organization = Decidim::Organization.first

mairie_toulouse = Decidim::Scope.create!(
  name: {
    en: "Toulouse city",
    fr: "Mairie de Toulouse"
  },
  code: "SCP-1",
  organization: organization
)

metropole_toulouse = Decidim::Scope.create!(
  name: {
    en: "Toulouse metropolis",
    fr: "Toulouse Métropole"
  },
  code: "SCP-2",
  organization: organization
)

Decidim::Scope.create!(
  name: {
    en: "Other",
    fr: "Autre"
  },
  code: "SCP-3",
  organization: organization
)


8.times do |idx|
  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.word,
    code: "SCPC-#{idx}",
    organization: organization,
    parent: mairie_toulouse
  )
end

8.times do |idx|
  Decidim::Scope.create!(
    name: Decidim::Faker::Localized.word,
    code: "SCPM-#{idx}",
    organization: organization,
    parent: metropole_toulouse
  )
end
