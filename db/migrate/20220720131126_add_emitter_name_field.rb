# frozen_string_literal: true

class AddEmitterNameField < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_participatory_processes, :emitter_name, :text
  end
end
