Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "categories#index"

  devise_for :users
  resources :categories do
    resources :tasks
  end

  # devise_for :users do
  #   resources :categories do
  #     resources :tasks
  #   end
  # end
end
