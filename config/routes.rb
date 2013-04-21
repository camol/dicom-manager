DicomManager::Application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }

  namespace :admin do
    resources :users, constraints: { id: /[^\/]+/ }
    resources :groups, only: [:index]
    resources :projects, only: [:index]
    resources :catalogs, only: [:index]
  end

  namespace :user do
    resources :groups
    resources :projects
  end

  #resources
  resources :permissions
  resources :groups
  resources :projects
  resources :users do
    member do
      get 'edit_share'
      post 'update_share'
    end
  end
  resources :catalogs do
    post 'move', on: :member
    resources :dicom_files
  end


  #paths
  root :to => "static_pages#home"

  match '/help', to: "static_pages#help"

  match '/about', to: "static_pages#about"
end
