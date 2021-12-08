# OVERLOADS

##  Backport child assemblies sort (#8)
### Added 
- app/commands/decidim/assemblies/admin/create_assembly.rb
- app/commands/decidim/assemblies/admin/update_assembly.rb
- app/forms/decidim/assemblies/admin/assembly_form.rb
- app/models/decidim/assembly.rb
- app/views/decidim/assemblies/admin/assemblies/_form.html.erb
- app/views/decidim/assemblies/assemblies/show.html.erb

##  Fix sub hero container (#13)
### Added
- app/cells/decidim/content_blocks/sub_hero/show.erb

##  Fix/linked assemblies (#18)
### Added
- app/models/decidim/participatory_process.rb
### Modified
- app/cells/decidim/participatory_processes/content_blocks/highlighted_processes/show.erb
- app/cells/decidim/participatory_processes/process_m/header.erb
- app/cells/decidim/participatory_processes/process_m_cell.rb

##  Clear user account (#20)
### Added 
- app/views/decidim/account/show.html.erb

##  Fix missing address field in participatory process (#21)
### Modified
- app/commands/decidim/participatory_processes/admin/create_participatory_process.rb
- app/commands/decidim/participatory_processes/admin/update_participatory_process.rb
- app/forms/decidim/participatory_processes/admin/participatory_process_form.rb
- app/views/decidim/participatory_processes/admin/participatory_processes/_form.html.erb

##  Fix proposal exporter (#31)
### Added 
- app/jobs/decidim/export_job.rb
- app/jobs/decidim/open_data_job.rb
- lib/extends/exporters/csv.rb
- lib/extends/exporters/exporter.rb
- lib/extends/exporters/json.rb
- lib/extends/serializer/result_serializer_extends.rb

### Modified 
- config/routes.rb
- app/views/layouts/decidim/_main_footer.html.erb
Deleted 
```html
<li><%= link_to t("layouts.decidim.footer.download_open_data"), decidim.open_data_download_path %></li>
```

##  Fix steps button when steps CTA enabled (#30)
### Added
- app/views/layouts/decidim/_process_header_steps.html.erb

##  Add emitter to participatory process (#39)
### Added
- app/assets/images/toulouse/*
- app/cells/decidim/card_m/emitter.erb
- app/cells/decidim/card_m/show.erb
- app/cells/decidim/participatory_processes/process_group_m_cell.rb
- app/cells/decidim/participatory_processes/process_m/emitter.erb
- app/helpers/emitter_helper.rb
- db/migrate/20210616093059_add_emitter_to_participatory_processes.rb

### Modified
- app/assets/stylesheets/decidim.scss
- app/cells/decidim/participatory_processes/content_blocks/highlighted_processes/show.erb:14
```ruby
              <% if display_emitter(process) %>
                <div class="card-data emitter-header">
                  <div class="large-4 small-12 columns card-data__item">
                    <%= display_emitter(process).try(:[], :picture) %>
                  </div>
                  <div class="small-12 large-8 columns card-data__item">
                    <%= display_emitter(process).try(:[], :text) %>
                  </div>
                </div>
              <% end %>
```
- app/cells/decidim/participatory_processes/content_blocks/highlighted_processes_cell.rb:8
```ruby
        include EmitterHelper
```
- app/cells/decidim/participatory_processes/process_m_cell.rb:10
```ruby
        include EmitterHelper
```
- app/commands/decidim/participatory_processes/admin/copy_participatory_process.rb:57
```ruby
emitter: @participatory_process.emitter,
```
- app/commands/decidim/participatory_processes/admin/create_participatory_process.rb:63
- app/commands/decidim/participatory_processes/admin/update_participatory_process.rb:77
```ruby
emitter: form.emitter,
```
- app/forms/decidim/participatory_processes/admin/participatory_process_form.rb
- app/helpers/application_helper.rb
- app/models/decidim/participatory_process.rb
- app/views/decidim/participatory_processes/admin/participatory_processes/_form.html.erb
- app/views/decidim/participatory_processes/participatory_processes/_promoted_process.html.erb
- config/initializers/decidim.rb

## Add SMS gateway service
### Added
- app/services/sms_gateway_service.rb
- app/views/decidim/verifications/sms/authorizations/edit.html.erb
- app/views/decidim/verifications/sms/authorizations/new.html.erb
### Modified
- config/initializers/decidim.rb
- config/initializers/decidim_verifications.rb
- config/initializers/extends.rb

##  Fix participatory process order (#40)
### Added 
- app/controllers/decidim/participatory_processes/participatory_process_groups_controller.rb

## Sort by alphanumeric and alphabetical order (#52)
### Added
- app/controllers/decidim/scopes_controller.rb
- app/helpers/decidim/check_boxes_tree_helper.rb
### Modified
- config/i18n-tasks.yml

## Add fonts and change logos (#47)
### Added
- app/assets/fonts/decidim/Gilroy/*
### Modified
- app/assets/stylesheets/_fontface.scss

## Sort processes by start date (#50)
- app/controllers/decidim/assemblies/assemblies_controller.rb
- app/models/decidim/participatory_process.rb

## Add module user exporter and configuration (#45)
### Added
- lib/extends/serializer/user_export_serializer_extends.rb
### Modified
- config/initializers/decidim.rb
- config/initializers/extends.rb

## Custom registration form and exports
### Added
- app/assets/javascripts/decidim/user_registrations.js.es6
- app/assets/stylesheets/decidim/modules/_shared.scss
- app/assets/stylesheets/decidim/modules/_signup.scss
- app/commands/decidim/create_registration.rb
- app/forms/decidim/registration_form.rb
- app/serializers/decidim/debates/debate_serializer.rb
- app/serializers/decidim/exporters/serializer.rb
- app/serializers/decidim/meetings/registration_serializer.rb
- app/views/decidim/admin/scope_types/index.html.erb
- app/views/decidim/devise/registrations/new.html.erb
- app/views/decidim/devise/shared/_links.html.erb
- app/views/decidim/devise/shared/_omniauth_buttons.html.erb
- db/migrate/20191211133811_add_registration_metadata_to_decidim_users.rb
- db/migrate/20191217093303_add_registration_metadata_to_decidim_users.decidim.rb
- lib/extends/serializer/comment_serializer_extends.rb
- lib/extends/serializer/proposal_serializer_extends.rb
- lib/extends/serializer/user_answers_serializer_extends.rb

### Modified
- config/i18n-tasks.yml
- config/locales/en.yml
- config/locales/fr.yml
- app/assets/javascripts/application.js:14
```js
  //= require jquery
```
- app/assets/stylesheets/decidim.scss:19
```scss
@import "decidim/modules/shared";
@import "decidim/modules/signup";
```
- config/i18n-tasks.yml

## Tests 
- spec/cells/decidim/content_blocks/sub_hero_cell_spec.rb
- spec/cells/decidim/participatory_processes/content_blocks/highlighted_processes_cell_spec.rb
- spec/commands/create_participatory_process_spec.rb
- spec/commands/decidim/copy_participatory_process_spec.rb
- spec/commands/decidim/create_assembly_spec.rb
- spec/commands/decidim/create_participatory_process_spec.rb
- spec/commands/decidim/update_participatory_process_spec.rb
- spec/commands/decidim/create_registration_spec.rb
- spec/controllers/registrations_controller_spec.rb
- spec/controllers/scopes_controller_spec.rb
- spec/factories.rb
- spec/forms/participatory_process_form_spec.rb
- spec/forms/registration_form_spec.rb
- spec/helpers/decidim/check_boxes_tree_helper_spec.rb
- spec/lib/exporters/csv_spec.rb
- spec/lib/exporters/json_spec.rb
- spec/models/decidim/assembly_spec.rb
- spec/models/decidim/participatory_process_spec.rb
- spec/serializers/comment_serializer_spec.rb
- spec/serializers/debate_serializer_spec.rb
- spec/serializers/decidim/exporters/serializer_spec.rb
- spec/serializers/proposal_serializer_spec.rb
- spec/serializers/registration_serializer_spec.rb
- spec/serializers/user_answer_serializer_spec.rb
- spec/shared/manage_processes_examples.rb
- spec/shared/participatory_process_administration_by_admin_shared_context.rb
- spec/shared/participatory_process_administration_shared_context.rb
- spec/shared/process_announcements_examples.rb
- spec/system/decidim/account_spec.rb
- spec/system/decidim/admin_copy_participatory_process_spec.rb
- spec/system/decidim/admin_import_participatory_process_spec.rb
- spec/system/decidim/admin_manages_participatory_processes_spec.rb
- spec/system/decidim/authentication_spec.rb
- spec/system/decidim/homepage_spec.rb
- spec/system/decidim/participatory_processes_spec.rb
- spec/system/decidim/registration_spec.rb
- spec/system/participatory_process_groups_spec.rb
- spec/system/registration_unbundled_consent_spec.rb
- spec/system/sms/code_request_spec.rb
- spec/system/sms/code_verification_spec.rb