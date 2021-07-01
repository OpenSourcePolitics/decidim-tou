class AddEmitterToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_participatory_processes, :emitter, :integer, default: 0
  end
end
