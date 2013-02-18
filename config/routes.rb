DicomManager::Application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }

  namespace :admin do
    resources :users, constraints: { id: /[^\/]+/ }
  end

  #resources
  resources :users
  resources :catalogs
  resources :dicom_files


  #paths
  root :to => "static_pages#home"

  match '/help', to: "static_pages#help"

  match '/about', to: "static_pages#about"
end
