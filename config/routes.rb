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
  resources :groups
  resources :projects
  resources :users
  resources :catalogs do
    resources :dicom_files, only: [:create, :show, :destroy] do
      # TO DO
      # Change route /catalog_id/dicom_files/:id to /catalog_id/:id
    end
  end


  #paths
  root :to => "static_pages#home"

  match '/help', to: "static_pages#help"

  match '/about', to: "static_pages#about"
end
