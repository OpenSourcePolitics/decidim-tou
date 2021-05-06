# frozen_string_literal: true

require "json"

# Exports a JSON version of a provided hash, given a collection and a
# Serializer.
module JsonExtend
  # Public: Generates a JSON representation of a collection and a
  # Serializer.
  #
  #
  # Returns an ExportData with the export.
  def export
    data = ::JSON.pretty_generate(@collection.map do |resource|
      @serializer.new(resource, @private_scope).serialize
    end)

    ExportData.new(data, "json")
  end
end

Decidim::Exporters::JSON.class_eval do
  prepend(JsonExtend)
end
