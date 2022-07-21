# frozen_string_literal: true

module EmitterHelper
  def display_emitter(process)
    return unless process.respond_to?(:emitter)
    return if process.attached_uploader(:emitter).path.nil?

    {
      picture: image_tag(process.attached_uploader(:emitter).path),
      text: t("emitter_text",
              developer_group: translated_attribute(process.developer_group),
              scope: "decidim.participatory_processes.emitter")
    }
  end

  def emitter_options
    options = []
    Decidim::ParticipatoryProcess.where(organization: current_organization).each do |p|
      next if p.emitter_name.blank?

      options << [p.emitter_name, p.id, { 'data-image': p.attached_uploader(:emitter).path }]
    end
    options
  end
end
