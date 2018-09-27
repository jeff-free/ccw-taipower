Rails.application.routes.draw do
  get 'relatives/index'
  devise_for :admins
  root controller: :pages, action: :index
  get :about, controller: :pages, action: :about
  get :knowledge, controller: :pages, action: :knowledge
  resources :relatives, only: :index
  namespace :admin do
    resources :expenditures do
      post :import, on: :collection
    end
    resources :relatives do
      post :import, on: :collection
    end
    resources :representatives do
      post :import, on: :collection
    end
    resources :organizations do
      collection do
        post :import_by_api
        post :import
      end
    end
    root controller: :base, action: :dashboard
  end
  resources :reports, only: :index
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
