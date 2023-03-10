# frozen_string_literal: true

require "spec_helper"

module Decidim
  module Assemblies
    describe AssembliesController, type: :controller do
      routes { Decidim::Assemblies::Engine.routes }

      let(:organization) { create(:organization) }

      let!(:unpublished_assembly) do
        create(
          :assembly,
          :unpublished,
          organization: organization
        )
      end

      let!(:published) do
        create(
          :assembly,
          :published,
          organization: organization
        )
      end

      let!(:promoted) do
        create(
          :assembly,
          :published,
          :promoted,
          organization: organization
        )
      end

      before do
        request.env["decidim.current_organization"] = organization
      end

      describe "published_assemblies" do
        context "when there are no published assemblies" do
          before do
            published.unpublish!
            promoted.unpublish!
          end

          it "redirects to 404" do
            expect { get :index }.to raise_error(ActionController::RoutingError)
          end
        end
      end

      describe "GET assemblies in json format" do
        let!(:first_level) { create(:assembly, :published, :with_parent, parent: published, organization: organization) }
        let!(:second_level) { create(:assembly, :published, :with_parent, parent: first_level, organization: organization) }
        let!(:third_level) { create(:assembly, :published, :with_parent, parent: second_level, organization: organization) }

        let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

        it "includes only published assemblies with their children (two levels)" do
          get :index, format: :json
          expect(parsed_response).to match_array(
            [
              {
                name: translated(promoted.title),
                children: []
              },
              {
                name: translated(published.title),
                children: [
                  {
                    name: translated(first_level.title),
                    children: [{ name: translated(second_level.title) }]
                  }
                ]
              }
            ]
          )
        end
      end

      describe "promoted_assemblies" do
        it "includes only promoted" do
          expect(controller.helpers.promoted_assemblies).to contain_exactly(promoted)
        end
      end

      describe "parent_assemblies" do
        let!(:child_assembly) { create(:assembly, parent: published, organization: organization) }

        it "includes only parent assemblies, with promoted listed first" do
          expect(controller.helpers.parent_assemblies.first).to eq(promoted)
          expect(controller.helpers.parent_assemblies.second).to eq(published)
        end
      end

      describe "assembly_participatory_processes" do
        let!(:participatory_processes) do
          5.times.map do
            create(
              :participatory_process,
              :published,
              organization: organization,
              start_date: Time.zone.now - rand(-2..3).days,
              end_date: Time.zone.now + rand(1..3).days
            )
          end
        end

        before do
          published.link_participatory_space_resources(participatory_processes, "included_participatory_processes")
          current_participatory_space = published
          controller.instance_variable_set(:@current_participatory_space, current_participatory_space)
        end

        it "includes only participatory processes related to the assembly, actives one by end_date then upcoming ones by start_date then past ones by end_date reversed" do
          sorted_participatory_processes = {
            active: participatory_processes.select(&:active?).sort_by(&:end_date),
            future: participatory_processes.select(&:upcoming?).sort_by(&:start_date),
            past: participatory_processes.select(&:past?).sort_by(&:end_date).reverse
          }

          expect(controller.helpers.assembly_participatory_processes).to eq(sorted_participatory_processes)
        end
      end

      describe "GET show" do
        context "when the assembly is unpublished" do
          it "redirects to sign in path" do
            get :show, params: { slug: unpublished_assembly.slug }

            expect(response).to redirect_to("/users/sign_in")
          end

          context "with signed in user" do
            let!(:user) { create(:user, :confirmed, organization: organization) }

            before do
              sign_in user, scope: :user
            end

            it "redirects to root path" do
              get :show, params: { slug: unpublished_assembly.slug }

              expect(response).to redirect_to("/")
            end
          end
        end
      end
    end
  end
end
