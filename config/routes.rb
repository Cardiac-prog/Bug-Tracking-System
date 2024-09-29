Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"
  root "projects#index"

  resources :projects do
    resources :feature_and_bugs do
      member do
        patch :assign_to_me
        patch :mark_as_resolved
      end
    end
  end
end
