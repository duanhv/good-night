Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:index]
      resources :follows, only: [:index, :create, :destroy]
      resources :clock_ins, only: [:index, :create]
      get "/clock_in_by_friend/:id", to: "clock_ins#clock_in_by_friend"
    end
  end
end
