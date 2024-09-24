Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }
  root "projects#index"

  resources :projects do
    resources :feature_and_bugs
  end
end
