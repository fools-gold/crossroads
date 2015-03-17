Rails.application.routes.draw do
  devise_for :users

  resource :team, only: [:show, :update, :edit]

  resources :users, only: [:index, :show, :update] do
    # get :statuses, on: :member
  end

  resources :hashtags, only: [:index, :show] do
    # get :statuses, on: :member
  end

  resources :statuses, except: [:show] do
    collection do
      get :search
      get :today
      get :yesterday
      constraints year: /\d{4}/, month: /(0?[1-9]|1[012])/, day: /(0?[1-9]|[12]\d|3[01])/ do
        get "/:year/:month/:day", action: :daily, as: :daily
        get "/:year/:month", action: :monthly, as: :monthly
        get "/:year", action: :yearly, as: :yearly
      end
    end
    resources :likes, only: [:create]
    resource :like, only: [:destroy]
  end

  get "/search", to: "search#index"
end
