Rails.application.routes.draw do
  devise_for :users

  resources :teams, only: [:show, :update]

  resources :users, only: [:index, :show, :update] do
    # get :statuses, on: :member
  end

  resources :hashtags, only: [:index, :show] do
    # get :statuses, on: :member
  end

  resources :statuses, except: [:show] do
    collection do
      get :today
      get :yesterday
      get "/:year/:month/:day", action: :on
    end
  end
end
