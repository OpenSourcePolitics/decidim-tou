# # frozen_string_literal: true
#
# require "decidim/translator_configuration_helper"
# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)
# # You can remove the 'faker' gem if you don't want Decidim seeds.
#
# Decidim::TranslatorConfigurationHelper.able_to_seed?
#
if ENV["HEROKU_APP_NAME"].present?
  ENV["DECIDIM_HOST"] = "#{ENV.fetch("HEROKU_APP_NAME", nil)}.herokuapp.com"
  ENV["SEED"] = "true"
end
Decidim.seed!

org = Decidim::Organization.first

actives = [
  {
             slug: "slug-#{Random.rand(1..9_999)}",
             weight: Random.rand(10),

             start_date: Time.current - 6.month,
             end_date: Time.current + 3.month
           },{
             slug: "slug-#{Random.rand(1..9_999)}",
             weight: Random.rand(10),

             start_date: Time.current - 1.month,
             end_date: Time.current + 1.month
           },
           {
             slug: "slug-#{Random.rand(1..9_999)}",
             weight: Random.rand(10),

             start_date: Time.current - 1.year,
             end_date: Time.current + 2.year
           }]

futures = [

  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current + 1.year,
    end_date: Time.current + 4.year
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current + 2.month,
    end_date: Time.current + 4.month
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current + 19.year,
    end_date: Time.current + 35.year
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current + 1.week,
    end_date: Time.current + 2.week
  },
]


pasts = [

  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current - 1.week,
    end_date: Time.current - 3.days
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current - 2.month,
    end_date: Time.current - 1.month
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current - 19.year,
    end_date: Time.current - 4.year
  },
  {
    slug: "slug-#{Random.rand(1..9_999)}",
    weight: Random.rand(10),

    start_date: Time.current - 10.year,
    end_date: Time.current - 1.week
  },
]


(actives + futures + pasts).each do |process|
  Decidim::ParticipatoryProcess.create!(
    title: { fr: "Participatory process d'essai (start: #{process[:start_date]})" },
    subtitle: { fr: "Participatory process d'essai" },
    description: { fr: "<p>Participatory process d'essai</p>" },
    short_description: { fr: "<p>Participatory process d'essai</p>" },
    published_at: Time.current,
    organization: org,
    slug: process[:slug],
    weight: process[:weight],
    start_date: process[:start_date],
    end_date: process[:end_date]
  )
end