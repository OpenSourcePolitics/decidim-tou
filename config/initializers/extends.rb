# frozen_string_literal: true

require "extends/controllers/decidim/meetings/meetings_controller_extends"
require "extends/commands/decidim/create_registration"

if Dir.glob("lib/extends/exporters/*.rb").blank?
  Rails.logger.warn("Extends not found (Looking at 'lib/extends/exporters/*.rb')")
else
  Dir.glob("lib/extends/exporters/*.rb").each { |f| load f }
end
