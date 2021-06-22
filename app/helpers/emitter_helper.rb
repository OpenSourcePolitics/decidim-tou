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
    image_tag("toulouse/logo-mairie-noir.png")
  end
end
