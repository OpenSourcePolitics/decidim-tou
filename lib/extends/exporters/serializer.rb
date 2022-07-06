# frozen_string_literal: true

module Decidim
  module ColumnsExportsTranslator
    module Exporters
      # Overrides Decidim::Exporters::Serializer
      module Serializer
        protected

        def t_column_name(attribute, scope_extension = "")
          I18n.t(attribute.to_sym, scope: i18n_scope + scope_extension, default: attribute.to_s)
        end

        def i18n_scope
          ""
        end
      end
    end
  end
end

Decidim::Exporters::Serializer.class_eval do
  prepend(Decidim::ColumnsExportsTranslator::Exporters::Serializer)
end
