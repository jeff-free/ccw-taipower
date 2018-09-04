Rails.application.routes.draw do
  devise_for :admins
  root controller: :pages, action: :index
  namespace :admin do
    resources :expenditures do
      collection :import
    end
    root controller: :base, action: :dashboard
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
