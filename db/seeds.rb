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
  ENV["DECIDIM_HOST"] = "#{ENV["HEROKU_APP_NAME"]}.herokuapp.com"
  ENV["SEED"] = "true"
end

Decidim.seed!

organization = Decidim::Organization.first
scope_type = Decidim::ScopeType.create!(organization: organization,
                           name: {"fr" => "Territoire"},
                           plural: {"fr" => "Territoires"}
)

["1.1 - Capitole / Arnaud Bernard / Carmes", "1.2 - Amidonniers / Compans-Caffarelli", "1.3 - Les Chalets / Bayard / Belfort / Saint Aubin / Dupuy", "2.1 - Saint-Cyprien", "2.2 - Croix-de-Pierre / Route d'Espagne", "3.1 - Minimes / Barrière de Paris / Ponts-Jumeaux", "3.2 - Sept-Deniers / Ginestous / Lalande", "4.1 - Lapujade / Bonnefoy / Périole / Marengo / La Colonne", "4.2 - Jolimont / Soupetard / Roseraie / Gloire / Gramont / Amouroux", "Hors Toulouse"].each do |scope|
  if scope == "Hors Toulouse"
    code = "HS"
  else
    code = scope.split('-').first&.strip
  end

  Decidim::Scope.create!(organization: organization,
                         name: { "fr" => scope },
                         scope_type: scope_type,
                         parent_id: nil,
                         code: code
  )
end
