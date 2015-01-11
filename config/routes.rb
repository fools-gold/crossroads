Rails.application.routes.draw do
  resources :teams, only: [:show, :update]

  resources :users, only: [:index, :show, :update] do
#     get :statuses, on: :member
  end

#   resources :hashtags, only: [:index, :show] do
#     get :statuses, on: :member
#   end

  resources :statuses, only: [:create, :update, :destroy]
end
