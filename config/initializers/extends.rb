# frozen_string_literal: true

require "extends/controllers/decidim/meetings/meetings_controller_extends"
require "extends/helpers/decidim/meetings/directory/application_helper_extends"
require "extends/helpers/decidim/assemblies/assemblies_helper_extends"
require "extends/helpers/decidim/accountability/application_helper_extends"
require "extends/cells/decidim/card_m_cell_extends"

def load_dir(directory)
  files = Dir.glob("lib/extends/#{directory}/*.rb")
  if files.blank?
    Rails.logger.warn("Extends not found (Looking at 'lib/extends/#{directory}/*.rb')")
    Rails.logger.warn("Exports columns name won't be translated")
  else
    files.each { |f| load f }
  end
end

load_dir "exporters"
load_dir "serializer"
