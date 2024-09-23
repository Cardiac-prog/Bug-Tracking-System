Rails.application.routes.draw do
  root "projects#index"

  resources :projects do
    resources :feature_and_bugs
  end
end
