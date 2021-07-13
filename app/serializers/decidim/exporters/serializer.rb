# frozen_string_literal: true

module Decidim
  module Exporters
    # This is an abstract class with a very naive default implementation
    # for the exporters to use. It can also serve as a superclass of your
    # own implementation.
    #
    # It is used to be run against each element of an exportable collection
    # in order to extract relevant fields. Every export should specify their
    # own serializer or this default will be used.
    class Serializer
      attr_reader :resource
      EXPORTABLE_LIVING_AREA = [
        :city_work_area,
        :metropolis_work_area,
        :city_residential_area,
        :metropolis_residential_area
      ].freeze

      # Initializes the serializer with a resource.
      #
      # resource - The Object to serialize.
      # private_scope - Boolean to differentiate open data export and administrator export. By default scope is public.
      def initialize(resource, private_scope = false)
        @resource = resource
        @private_scope = private_scope
      end

      # Public: Returns a serialized view of the provided resource.
      #
      # Returns a nested Hash with the fields.
      def serialize
        @resource.to_h.merge options_merge(admin_extra_fields)
      end

      private

      # Private: Returns a Hash with additional fields to export if the export is done by administrator
      #
      # Returns a empty hash or Hash with some other fields
      def options_merge(options = {})
        return {} unless options.is_a?(Hash) && @private_scope

        options
      end

      # Private: Returns a Hash with additional fields that administrator want to see in export
      #
      # Returns a Hash
      def admin_extra_fields
        {}
      end

      # Private: Find a scope area and returns the translated name
      def scope_area_name(id)
        translated_attribute(Decidim::Scope.find(id)[:name])
      rescue ActiveRecord::RecordNotFound
        ""
      end

      # Private: Returns a specific value from registration_metadata hash
      def key_from_registration_metadata(user, sym_target)
        registration_metadata = user.try(:registration_metadata)
        return "" if registration_metadata.nil?

        if EXPORTABLE_LIVING_AREA.include? sym_target
          scope_area_name(registration_metadata[sym_target.to_s])
        else
          registration_metadata[sym_target.to_s] || ""
        end
      end

      def t_column_name(attribute, scope_extension = "")
        I18n.t(attribute.to_sym, scope: i18n_scope + scope_extension)
      end

      def i18n_scope
        ""
      end
    end
  end
end
