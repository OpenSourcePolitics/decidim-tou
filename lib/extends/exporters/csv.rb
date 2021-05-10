# frozen_string_literal: true

require "csv"

# Exports any serialized object (Hash) into a readable CSV. It transforms
# the columns using slashes in a way that can be afterwards reconstructed
# into the original nested hash.
#
# For example, `{ name: { ca: "Hola", en: "Hello" } }` would result into
# the columns: `name/ca` and `name/es`.
module CSVExporterExtend
  private

  def processed_collection
    @processed_collection ||= collection.map do |resource|
      flatten(@serializer.new(resource, @private_scope).serialize)
    end
  end
end

Decidim::Exporters::CSV.class_eval do
  prepend(CSVExporterExtend)
end
