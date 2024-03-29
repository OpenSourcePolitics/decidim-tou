# frozen_string_literal: true

module Decidim
  module ParticipatoryProcesses
    # This cell renders the Medium (:m) process group card
    # for an given instance of a ProcessGroup
    class ProcessGroupMCell < Decidim::CardMCell
      include EmitterHelper

      private

      def has_image?
        true
      end

      def resource_image_path
        model.attached_uploader(:hero_image).path
      end

      def title
        translated_attribute model.title
      end

      def resource_path
        Decidim::ParticipatoryProcesses::Engine.routes.url_helpers.participatory_process_group_path(model)
      end

      def step_title
        translated_attribute model.active_step.title
      end

      def card_classes
        ["card--process", "card--stack"].join(" ")
      end

      def statuses
        super << :processes_count
      end

      def processes_count_status
        content_tag(
          :strong,
          "#{t("layouts.decidim.participatory_process_groups.participatory_process_group.processes_count")}  #{processes_visible_for_user}"
        )
      end

      def processes_visible_for_user
        processes = model.participatory_processes.published

        if current_user
          return processes.count.to_s if current_user.admin

          processes.visible_for(current_user).count.to_s
        else
          processes.public_spaces.count.to_s
        end
      end

      def first_participatory_process
        model.participatory_processes.first
      end

      def linked_assemblies
        first_participatory_process.linked_participatory_space_resources(:assembly, "included_participatory_processes")
                                   .public_spaces
                                   .sort_by { |item| item.title[I18n.locale.to_s] }
      end
    end
  end
end
