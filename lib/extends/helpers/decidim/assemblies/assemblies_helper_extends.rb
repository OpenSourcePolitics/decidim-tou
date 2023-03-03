# frozen_string_literal: true

module Decidim
  module Assemblies
    module AssembliesHelperExtends
      def participatory_processes_for_assembly(assembly_participatory_processes)
        return if assembly_participatory_processes.values.all?(&:empty?)

        html = ""
        html += %( <div class="section"> ).html_safe
        html += %( <h4 class="section-heading">#{t("assemblies.show.related_participatory_processes", scope: "decidim")} <span class="margin-right-1"></span> ).html_safe

        assembly_participatory_processes.each do |type, processes|
          next if processes.empty?

          html += %( <a href="##{type}_assembly_participatory_processes" class="order-by__tab text-small">
            #{t("assemblies.show.#{type}_assembly_participatory_processes_mini", scope: "decidim")}
            (#{processes.count})</a> ).html_safe
        end

        html += %( </h4> ).html_safe
        html += %( <div class="column"> ).html_safe

        assembly_participatory_processes.each do |type, processes|
          next if processes.empty?

          html += %( <h5 id="#{type}_assembly_participatory_processes" class="section-heading">
            #{t("assemblies.show.#{type}_assembly_participatory_processes", scope: "decidim")}</h5> ).html_safe
          html += %( <div class="row small-up-1 medium-up-2 card-grid"> ).html_safe
          processes.each do |process|
            html += render partial: "decidim/participatory_processes/participatory_process", locals: { participatory_process: process }
          end
          html += %( </div> ).html_safe
        end

        html += %( </div> ).html_safe
        html += %( </div> ).html_safe

        html.html_safe
      end
    end
  end
end

Decidim::Assemblies::AssembliesHelper.module_eval do
  prepend(Decidim::Assemblies::AssembliesHelperExtends)
end
