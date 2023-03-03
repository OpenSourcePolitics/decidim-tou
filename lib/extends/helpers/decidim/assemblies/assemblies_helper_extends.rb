# frozen_string_literal: true

module Decidim
  module Assemblies
    module AssembliesHelperExtends
      def participatory_processes_for_assembly(assembly_participatory_processes)
        html = ""
        html += %( <div class="section"> ).html_safe
        html += %( <h4 class="section-heading">#{t("assemblies.show.related_participatory_processes", scope: "decidim")}</h4> ).html_safe
        html += %( <div class="column"> ).html_safe
        assembly_participatory_processes.each do |type, processes|
          html += %( <h5 class="section-heading">#{t("assemblies.show.#{type}_assembly_participatory_processes", scope: "decidim")}</h5> ).html_safe unless processes.empty?
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
