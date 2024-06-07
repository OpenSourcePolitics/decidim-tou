# frozen_string_literal: true

Decidim::Emitter.configure do |config|
  config.exclude_extends = [:participatory_process_form, :participatory_process_create, :participatory_process_copy, :participatory_process_update]
end
