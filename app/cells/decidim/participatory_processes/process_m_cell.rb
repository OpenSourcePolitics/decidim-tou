# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This cell renders the Medium (:m) process card
    # for an given instance of a Process
    class ProcessMCell < Decidim::CardMCell
      include Decidim::SanitizeHelper
      include Decidim::TranslationsHelper

      private

      def has_image?
        true
      end

      def has_state?
        model.past?
      end

      def has_badge?
        false
      end

      def has_step?
        model.active_step.present?
      end

      def state_classes
        return unless model.past?

        ["alert"]
      end

      def resource_path
        Decidim::ParticipatoryProcesses::Engine.routes.url_helpers.participatory_process_path(model)
      end

      def resource_image_path
        model.hero_image.url
      end

      def step_cta_text
        if translated_in_current_locale?(model.active_step&.cta_text)
          translated_attribute(model.active_step.cta_text)
        else
          t(model.cta_button_text_key_accessible, resource_name: title, scope: "layouts.decidim.participatory_processes.participatory_process")
        end
      end

      def step_cta_path
        if model.active_step&.cta_path.present?
          path, params = resource_path.split("?")

          "#{path}/#{model.active_step.cta_path}" + (params.present? ? "?#{params}" : "")
        else
          resource_path
        end
      end

      def step_title
        translated_attribute model.active_step.title
      end

      def base_card_class
        "card--process"
      end

      def statuses
        [:creation_date, :follow]
      end

      def resource_icon
        icon "processes", class: "icon--big"
      end

      def start_date
        model.start_date
      end

      def end_date
        model.end_date
      end

      def decidim_assemblies
        Decidim::Assemblies::Engine.routes.url_helpers
      end

      def display_emitter(process)
        return if process.emitter == "unspecified"

        {
          picture: render_picture(process.emitter),
          text: t("emitter_text",
                  emitter: t(process.emitter, scope: "decidim.participatory_processes.emitter.values"),
                  scope: "decidim.participatory_processes.emitter")
        }
      end

      private

      def render_picture(emitter)
        if emitter == "city"
          city_picture
        elsif emitter == "metropolis"
          metropolis_picture
        else
          metropolis_picture.concat(city_picture)
        end
      end

      def metropolis_picture
        image_tag("toulouse/logo-metropole-grey.png")
      end

      def city_picture
        image_tag("toulouse/logo-mairie.png")
      end
    end
  end
end
