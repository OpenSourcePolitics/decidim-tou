# frozen_string_literal: true

module ResultSerializerExtends
  # Public: Initializes the serializer with a result.
  def initialize(result, private_scope = false)
    @result = result
  end
end

Decidim::Accountability::ResultSerializer.class_eval do
  prepend(ResultSerializerExtends)
end
