# frozen_string_literal: true

module ApplicationHelper
  def linked_assemblies_for(process)
    process.linked_participatory_space_resources(:assembly, "included_participatory_processes").public_spaces
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
