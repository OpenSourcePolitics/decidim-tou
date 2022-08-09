# frozen_string_literal: true

class ModifyEmitterInParticipatoryProcesses < ActiveRecord::Migration[6.0]
  def up
    change_column :decidim_participatory_processes, :emitter, :string

    add_column :decidim_participatory_processes, :emitter_name, :text
  end

  def down; end
end
