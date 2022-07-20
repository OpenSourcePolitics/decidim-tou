# frozen_string_literal: true

require "spec_helper"

module Decidim
  describe Exporters::Serializer do
    let(:subject) { described_class.new(resource) }
    let(:resource) { OpenStruct.new(id: 1, name: "John") }

    describe "#t_column_name" do
      context "when translation exists" do
        before do
          allow(I18n).to receive(:t).with(:name, scope: "", default: "name").and_return("Translated name")
        end

        it "returns the translation" do
          expect(subject.send(:t_column_name, "name")).to eq("Translated name")
        end

        context "and #i18n_scope is defined" do
          before do
            allow(subject).to receive(:i18n_scope).and_return("decidim.i18n.scope")
            allow(I18n).to receive(:t).with(:name, scope: "decidim.i18n.scope", default: "name").and_return("Translated i18n name")
          end

          it "returns the translation" do
            expect(subject.send(:t_column_name, "name")).to eq("Translated i18n name")
          end
        end
      end

      context "when translation does not exist" do
        it "returns thegiven attribute" do
          expect(subject.send(:t_column_name, "name")).to eq("name")
        end
      end
    end

    describe "#serialize" do
      it "turns the object into a hash" do
        expect(subject.serialize).to eq(id: 1, name: "John")
      end
    end

    describe "#event_name" do
      it "turns class name into an event name" do
        expect(subject.event_name).to eq("decidim.serialize.exporters.serializer")
      end
    end

    context "when subscribed to the serialize event" do
      ActiveSupport::Notifications.subscribe("decidim.serialize.exporters.serializer") do |_event_name, data|
        data[:serialized_data][:johnny_boy] = "Get up Johnny boy because we all need you now"
      end

      it "includes new field" do
        expect(subject.run).to eq(resource.to_h.merge({ johnny_boy: "Get up Johnny boy because we all need you now" }))
      end
    end
  end
end
