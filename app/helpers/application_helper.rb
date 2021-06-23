# frozen_string_literal: true

module ApplicationHelper
  include EmitterHelper

  def linked_assemblies_for(process)
    process.linked_participatory_space_resources(:assembly, "included_participatory_processes").public_spaces
  end
end
