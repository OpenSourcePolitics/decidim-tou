# frozen_string_literal: true

class ModifyEmitterField < ActiveRecord::Migration[6.0]
  def change
    change_column :decidim_participatory_processes, :emitter, :string
  end
end
