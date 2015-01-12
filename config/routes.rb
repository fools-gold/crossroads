Rails.application.routes.draw do
  devise_for :users

  resource :team

  resources :users, only: [:index, :show, :update] do
#     get :statuses, on: :member
  end

  resources :hashtags, only: [:index, :show] do
#     get :statuses, on: :member
  end

  resources :statuses, only: [:create, :update, :destroy]
end
