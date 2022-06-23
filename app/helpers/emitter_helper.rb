# frozen_string_literal: true

module EmitterHelper
  def display_emitter(process)
    return unless process.respond_to?(:emitter)
    return if process.emitter == "unspecified"

    {
      picture: render_picture(process.emitter),
      text: t("emitter_text",
              developer_group: translated_attribute(process.developer_group),
              scope: "decidim.participatory_processes.emitter")
    }
  end

  private

  def render_picture(emitter)
    case emitter
    when "city"
      city_picture
    when "metropolis"
      metropolis_picture
    else
      metropolis_picture.concat(city_picture)
    end
  end

  def metropolis_picture
    image_pack_tag("media/images/logo-metropole-grey.png")
  end

  def city_picture
    image_pack_tag("media/images/logo-mairie-noir.png")
  end
end
