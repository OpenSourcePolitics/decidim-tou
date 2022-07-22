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
    Decidim::ParticipatoryProcess.where(organization: current_organization).where.not(emitter_name: nil).map do |pp|
      [pp.emitter_name, pp.id, { 'data-image': pp.attached_uploader(:emitter).path }]
    end
  end
end
