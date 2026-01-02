Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resources :events, only: [:create, :index] do
    collection do
      post :batch_create
      post :purge
    end
  end
end
