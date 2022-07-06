# frozen_string_literal: true

# Overrides Decidim::Exporters::Serializer
module SerializerExporterExtend
  protected

  def t_column_name(attribute, scope_extension = "")
    I18n.t(attribute.to_sym, scope: i18n_scope + scope_extension, default: attribute.to_s)
  end

  def i18n_scope
    ""
  end
end


Decidim::Exporters::Serializer.class_eval do
  prepend(SerializerExporterExtend)
end
