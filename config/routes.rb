RailsSurvey::Application.routes.draw do

  devise_for :users
  resources :responses

  resources :surveys

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :instruments, only: [:index, :show]
      resources :questions, only: [:index, :show]
      resources :options, only: [:index, :show]
      resources :surveys, only: [:create]
      resources :responses, only: [:create]
    end
  end

  root to: 'instruments#index'
  resources :instruments
  resources :graphs
  get '/realtime' => "graphs#realtime"
  resources :devices, only: [:index]
end
