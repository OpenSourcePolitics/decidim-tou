# frozen_string_literal: true

require "extends/controllers/decidim/meetings/meetings_controller_extends"

if Dir.glob("lib/extends/exporters/*.rb").blank?
  Rails.logger.warn("Extends not found (Looking at 'lib/extends/exporters/*.rb')")
  Rails.logger.warn("Exports columns name won't be translated")
else
  Dir.glob("lib/extends/exporters/*.rb").each { |f| load f }
end
