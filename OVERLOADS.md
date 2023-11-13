# Overrides

## Load decidim-awesome assets only if dependencie is present
* `app/views/layouts/decidim/_head.html.erb:33`

## Fix geocoded proposals
* `app/controllers/decidim/proposals/proposals_controller.rb:44`
```ruby
          @all_geocoded_proposals = @base_query.geocoded.where.not(latitude: Float::NAN, longitude: Float::NAN)
```

##  Fix meetings registration serializer
* `app/serializers/decidim/meetings/registration_serializer.rb`
## Fix UserAnswersSerializer for CSV exports
* `lib/decidim/forms/user_answers_serializer.rb`
## 28c8d74 - Add basic tests to reference package (#1), 2021-07-26
* `lib/extends/commands/decidim/admin/create_participatory_space_private_user_extends.rb`
* `lib/extends/commands/decidim/admin/impersonate_user_extends.rb`
##  cd5c2cc - Backport fix/user answers serializer (#11), 2021-09-30
* `lib/decidim/forms/user_answers_serializer.rb`
## Fix metrics issue in admin dashboard
 - **app/stylesheets/decidim/vizzs/_areachart.scss**
```scss
    .area{
        fill: rgba($primary, .2);;
    }
```

## Add FC Connect SSO
 - **app/views/decidim/devise/shared/_omniauth_buttons.html.erb**
```ruby
<% if provider.match?("france") %>
```

* `app/views/decidim/scopes/picker.html.erb`
c76437f - Modify cancel button behaviour to match close button, 2022-02-08

* `app/helpers/decidim/backup_helper.rb`
83830be - Add retention service for daily backups (#19), 2021-11-09

* `app/services/decidim/s3_retention_service.rb`
de6d804 - fix multipart object tagging (#40) (#41), 2021-12-24

* `config/initializers/omniauth_publik.rb`
9d50925 - Feature omniauth publik (#46), 2022-01-18

* `lib/tasks/restore_dump.rake`
705e0ad - Run rubocop, 2021-12-01

## Remove validations
* `app/forms/decidim/decidim_awesome/proposals/proposal_wizard_create_step_form_override.rb`
* `app/validators/etiquette_validator.rb`
* `app/cells/decidim/card_m/emitter.erb`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/cells/decidim/card_m/show.erb`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/cells/decidim/participatory_processes/content_blocks/highlighted_processes/show.erb`
ddf389d - Prevent display linked assemblies when disabled (#89), 2022-09-02

* `app/cells/decidim/participatory_processes/content_blocks/highlighted_processes_cell.rb`
4588f9c - Sort linked assemblies by title (#88), 2022-09-02

* `app/cells/decidim/participatory_processes/process_group_m_cell.rb`
4588f9c - Sort linked assemblies by title (#88), 2022-09-02

* `app/cells/decidim/participatory_processes/process_m/emitter.erb`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/cells/decidim/participatory_processes/process_m/header.erb`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/cells/decidim/participatory_processes/process_m_cell.rb`
a4075c7 - fix display linked assemblies, 2022-07-29

* `app/commands/decidim/create_registration.rb`
8cf2481 - feat: email_on_notification default to true (#153), 2023-10-30

* `app/commands/decidim/participatory_processes/admin/copy_participatory_process.rb`
a4075c7 - fix display linked assemblies, 2022-07-29

* `app/commands/decidim/participatory_processes/admin/create_participatory_process.rb`
7b2b511 - Fix interactive maps (#81), 2022-08-03

* `app/commands/decidim/participatory_processes/admin/update_participatory_process.rb`
7b2b511 - Fix interactive maps (#81), 2022-08-03

* `app/controllers/decidim/assemblies/assemblies_controller.rb`
97ddfbe - [Feature] - Add Future Processes to Linked Assemblies (#110), 2023-03-10

* `app/controllers/decidim/devise/registrations_controller.rb`
0e8fe0f - Feature/add friendly signup (#121), 2023-04-17

* `app/forms/decidim/participatory_processes/admin/participatory_process_form.rb`
7b2b511 - Fix interactive maps (#81), 2022-08-03

* `app/forms/decidim/registration_form.rb`
585fd97 - feat: Add newsletter to registration form (#152), 2023-10-30

* `app/forms/decidim/user_interest_scope_form.rb`
cf7bf39 - [Feature] - Sort user interests (#87), 2022-08-31

* `app/forms/decidim/user_interests_form.rb`
cf7bf39 - [Feature] - Sort user interests (#87), 2022-08-31

* `app/helpers/decidim/check_boxes_tree_helper.rb`
ee48a37 - [Fix] - Sort of checkboxes scopes (#92), 2022-09-19

* `app/helpers/decidim/participatory_processes/application_helper.rb`
f91921b - Feature/add linked assemblies (#71), 2022-07-13

* `app/helpers/emitter_helper.rb`
4caed1c - retour produits, 2022-07-27

* `app/jobs/decidim/open_data_job.rb`
4fb7bb7 - [Fix] - OpenData Failing Job (#118), 2023-03-22

* `app/mailers/decidim/statutory_representative_mailer.rb`
50d5c8a - Feature/custom registration form (#70), 2022-07-18

* `app/packs/entrypoints/application.js`
d0a11da - Add complex emitter (#73), 2022-07-25

* `app/packs/images/FCboutons-10.png`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/FCboutons-10@2x.png`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/decidim/cc-by-sa--inv.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/decidim/cc-by-sa.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/decidim/decidim-logo-mobile--inv.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/decidim/decidim-logo-mobile.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/decidim/decidim-logo.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/france-connect-logo-mono.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/france-connect-logo.svg`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/images/logo-mairie-noir.png`
8b2ed5d - Backport/footer (#66), 2022-07-06

* `app/packs/images/logo-mairie.png`
8b2ed5d - Backport/footer (#66), 2022-07-06

* `app/packs/images/logo-metropole-grey.png`
8b2ed5d - Backport/footer (#66), 2022-07-06

* `app/packs/images/logo-metropole.png`
8b2ed5d - Backport/footer (#66), 2022-07-06

* `app/packs/images/toulouse/logo-mairie-noir.png`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/packs/images/toulouse/logo-mairie.png`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/packs/images/toulouse/logo-metropole-grey.png`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/packs/images/toulouse/logo-metropole.png`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/packs/src/decidim/decidim_application.js`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/src/decidim/emitter.js`
4caed1c - retour produits, 2022-07-27

* `app/packs/src/decidim/user_registrations.js`
0e8fe0f - Feature/add friendly signup (#121), 2023-04-17

* `app/packs/stylesheets/decidim/_decidim-settings.scss`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/stylesheets/decidim/decidim_application.scss`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/packs/stylesheets/decidim/email/_email-custom.scss`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/packs/stylesheets/decidim/modules/_footer.scss`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/packs/stylesheets/decidim/modules/_sign_up.scss`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/packs/stylesheets/decidim/participatory_processes/participatory_processes.scss`
f91921b - Feature/add linked assemblies (#71), 2022-07-13

* `app/packs/stylesheets/decidim/vizzs/_areachart.scss`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/serializers/decidim/surveys/data_importer.rb`
ff4bdc4 - [Fix] - Import error (#95), 2022-09-21

* `app/services/decidim/action_log_service.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/services/decidim/database_service.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/services/decidim/notification_service.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/services/decidim/repair_nickname_service.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/services/decidim/surveys_service.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/services/sms_gateway_service.rb`
762e314 - Backport https://github.com/OpenSourcePolitics/decidim-tou/pull/41 (#69), 2022-07-12

* `app/uploaders/decidim/emitter_uploader.rb`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/views/decidim/account/show.html.erb`
3b31570 - Fix - Account Language Selection || Fix language helper variable interpretation (#77), 2022-07-26

* `app/views/decidim/accountability/results/_scope_filters.html.erb`
b5f023d - [Fix] Subscopes Order Tags in Accountability Page (#114), 2023-03-09

* `app/views/decidim/blogs/posts/_posts.html.erb`
0dac1cd - [Fix] Fix global errors (#147), 2023-10-11

* `app/views/decidim/budgets/projects/_count.html.erb`
457a1a0 - fix projects display (#96), 2022-10-17

* `app/views/decidim/devise/registrations/new.html.erb`
585fd97 - feat: Add newsletter to registration form (#152), 2023-10-30

* `app/views/decidim/participatory_processes/admin/participatory_processes/_form.html.erb`
7b2b511 - Fix interactive maps (#81), 2022-08-03

* `app/views/decidim/participatory_processes/participatory_processes/_promoted_process.html.erb`
5642632 - [Fix] - Participatory processes images not displayed (#133), 2023-06-20

* `app/views/decidim/participatory_processes/participatory_processes/show.html.erb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `app/views/decidim/statutory_representative_mailer/inform.html.erb`
50d5c8a - Feature/custom registration form (#70), 2022-07-18

* `app/views/decidim/verifications/sms/authorizations/edit.html.erb`
b21c9cd - Fix conflicts (#116), 2023-03-14

* `app/views/decidim/verifications/sms/authorizations/new.html.erb`
762e314 - Backport https://github.com/OpenSourcePolitics/decidim-tou/pull/41 (#69), 2022-07-12

* `app/views/layouts/decidim/_mini_footer.html.erb`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `app/views/layouts/decidim/_process_header.html.erb`
a4075c7 - fix display linked assemblies, 2022-07-29

* `app/views/layouts/decidim/_social_media_links.html.erb`
4c1cf80 - Add emitter (#72), 2022-07-20

* `app/views/layouts/decidim/_wrapper.html.erb`
b21c9cd - Fix conflicts (#116), 2023-03-14

* `app/views/static/api/docs/assets/images/graphiql-headers.png`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/images/graphiql-variables.png`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/images/graphiql.png`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/images/menu.png`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/images/navbar.png`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/style.css`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_B_0.eot`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_B_0.ttf`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_B_0.woff`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_B_0.woff2`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_C_0.eot`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_C_0.ttf`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_C_0.woff`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_C_0.woff2`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_D_0.eot`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_D_0.ttf`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_D_0.woff`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_D_0.woff2`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_E_0.eot`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_E_0.ttf`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_E_0.woff`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/assets/webfonts/2C4B9D_E_0.woff2`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/directive/deprecated/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/directive/include/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/directive/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/directive/oneof/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/directive/skip/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/enum/__directivelocation/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/enum/__typekind/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/enum/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/categoryfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/componentfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/componentsort/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/participatoryprocessfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/participatoryprocesssort/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/postfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/postsort/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/proposalfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/proposalsort/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/userentityfilter/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/input_object/userentitysort/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/amendableentityinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/amendableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/attachableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/author/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/authorableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/categoriescontainerinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/categorizableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/coauthorableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/commentableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/componentinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/endorsableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/fingerprintinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/meetingslinkedresourcesinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/participatoryspaceinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/participatoryspaceresourceableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/questionnaireentityinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/scopableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/servicesinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/timestampsinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/interface/traceableinterface/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/mutation/comment/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/mutation/commentable/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__directive/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__enumvalue/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__field/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__inputvalue/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__schema/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/__type/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/accountability/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/amendment/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/answeroption/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/area/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/areatype/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/assembliestype/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/assembly/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/assemblymember/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/attachment/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/blogs/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/budget/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/budgetconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/budgetedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/budgets/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/category/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/comment/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/commentable/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/commentablemutation/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/commentmutation/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/component/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/conference/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/conferencemedialink/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/conferencepartner/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/conferencespeaker/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/coordinates/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/debate/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/debateconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/debateedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/debates/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/decidim/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/fingerprint/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/hashtagtype/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/localizedstring/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meeting/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetingagenda/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetingagendaitem/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetingconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetingedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetings/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/meetingservice/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/metric/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/metrichistory/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/organization/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/page/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/pageconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/pageedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/pageinfo/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/pages/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryprocess/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryprocessgroup/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryprocessstep/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryprocesstype/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryspace/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryspacelink/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/participatoryspacemanifest/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/post/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/postconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/postedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/project/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/proposal/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/proposalconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/proposaledge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/proposals/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/quantifiabletranslatedfield/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/question/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/questionnaire/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/result/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/resultconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/resultedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/scope/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/session/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/sortition/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/sortitionconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/sortitionedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/sortitions/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/statistic/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/status/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/survey/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/surveyconnection/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/surveyedge/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/surveys/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/timelineentry/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/traceversion/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/translatedfield/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/user/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/object/usergroup/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/operation/mutation/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/operation/query/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/boolean/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/date/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/datetime/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/float/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/id/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/int/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/json/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/scalar/string/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `app/views/static/api/docs/union/index.html`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `config/assets.rb`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `config/initializers/awesome_map.rb`
f12c07d - Bump Develop on 0.25 (#104), 2022-05-10

* `config/initializers/decidim_meetings.rb`
9d262d0 - linter, 2022-12-26

* `config/initializers/doorkeeper.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `config/initializers/extends.rb`
92fbf88 - fix: Remove verification conflicts (#155), 2023-11-10

* `config/initializers/friendly_signup.rb`
4995cbd - bump: Decidim to 0.28, 2023-11-13

* `config/initializers/health_check.rb`
0305923 - preparation ih (#124), 2023-05-12

* `config/initializers/rack_attack.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `config/initializers/sidekiq_alive.rb`
0305923 - preparation ih (#124), 2023-05-12

* `config/shakapacker.yml`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `config/webpack/custom.js`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `config/webpack/webpack.config.js`
cae20aa - fix: Move webpacker to Shakapacker on 0.28, 2023-11-13

* `lib/active_storage/downloadable.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/active_storage/migrator.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim/assets_hash.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim/dev/test/w3c_rspec_validators_overrides.rb`
5baf5c4 - fix failing test (#104), 2022-12-27

* `lib/decidim/participatory_processes/participatory_space.rb`
f91921b - Feature/add linked assemblies (#71), 2022-07-13

* `lib/decidim/rspec_runner.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/config.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/commands/admin.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/commands/organization.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/commands/system_admin.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/configuration.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/configuration_exporter.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/manager.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/organization_exporter.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/k8s/secondary_hosts_checker.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/rack_attack/fail2ban.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/rack_attack/throttling.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/rack_attack.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/decidim_app/sentry_setup.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/extends/commands/decidim/verifications/authorize_user_extends.rb`
92fbf88 - fix: Remove verification conflicts (#155), 2023-11-10

* `lib/extends/controllers/decidim/devise/sessions_controller_extends.rb`
7010950 - Fix undefined method blocked for admins (#120), 2022-06-13

* `lib/extends/controllers/decidim/meetings/meetings_controller_extends.rb`
b2b7a6b - Move overrides to extend for meetings controller, 2022-05-13

* `lib/extends/exporters/data_serializer.rb`
b34452b - [Feature] - Translate exporters columns (#67), 2022-07-07

* `lib/extends/exporters/proposal_serializer.rb`
81be3e0 - fix: phone numbers not found in exports (#150), 2023-10-12

* `lib/extends/exporters/serializer.rb`
b34452b - [Feature] - Translate exporters columns (#67), 2022-07-07

* `lib/extends/helpers/decidim/accountability/application_helper_extends.rb`
b5f023d - [Fix] Subscopes Order Tags in Accountability Page (#114), 2023-03-09

* `lib/extends/helpers/decidim/assemblies/assemblies_helper_extends.rb`
97ddfbe - [Feature] - Add Future Processes to Linked Assemblies (#110), 2023-03-10

* `lib/extends/helpers/decidim/meetings/directory/application_helper_extends.rb`
2a6d4c2 - [Fix] - Scopes order in Meetings directory (#111), 2023-03-22

* `lib/extends/serializer/user_answers_serializer_extends.rb`
7b13de1 - Add email / name to user answers form exporter (#83), 2022-08-09

* `lib/logger_with_stdout.rb`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/tasks/decidim_app.rake`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/tasks/migrate.rake`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/tasks/repair_data.rake`
c6f3a03 - bump develop from master (#145), 2023-09-07

* `lib/tasks/repare_data.rake`
86de34d - Fix/nickname invalid (#101), 2023-01-16

* `lib/tasks/scaleway.rake`
c6f3a03 - bump develop from master (#145), 2023-09-07

