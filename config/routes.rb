# frozen_string_literal: true

require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  # Disable open-data route
  get '/open-data/download' => redirect('/')

  authenticate :admin do
    mount Sidekiq::Web => "/sidekiq"
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  mount Decidim::Core::Engine => "/"

  # mount Decidim::Map::Engine => '/map'
  #
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Decidim::Core::Engine.routes.draw do
  resource :user_complete_registration, only: [:show, :update], controller: "user_complete_registration"
end
