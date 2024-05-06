Rails.application.routes.draw do
  devise_for :users
  resources :advertisements
  resources :vrassets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Route used to trigger the random image method from the Advertisements_controller.rb where it will retun a random image
  get 'get_image', to: 'advertisements#get_image'

  # Defines the root path route ("/")
  root "vrassets#index"
end
