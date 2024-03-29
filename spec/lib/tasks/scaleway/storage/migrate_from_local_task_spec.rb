# frozen_string_literal: true

require "spec_helper"

describe "rake scaleway:storage:migrate_from_local", type: :task do
  it "preloads the Rails environment" do
    expect(task.prerequisites).to include "environment"
  end

  it "invokes the migrator" do
    expect(ActiveStorage::Migrator).to receive(:migrate!).at_least(:once).with(:local, :scaleway).and_return(true)

    task.execute
  end
end
