DicomManager::Application.routes.draw do

	 resources :messages, :only => [:new, :create] do
	   collection do
       get 'admission_request'
       post 'send_admission_request'
	     get 'token' => 'messages#token', :as => 'token'
	     post 'empty/:messagebox' => 'messages#empty', :as => 'empty'
	     put 'update' => 'messages#update'
	     get ':messagebox/show/:id' => 'messages#show', :as => 'show', :constraints => { :messagebox => /inbox|outbox|trash/ }
	     get '(/:messagebox)' => 'messages#index', :as => 'box', :constraints => { :messagebox => /inbox|outbox|trash/ }
	   end
	 end


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
    resources :dicom_files do
      post 'manage', on: :collection
    end
  end


  #paths
  root :to => "static_pages#home"

  match '/help', to: "static_pages#help"

  match '/about', to: "static_pages#about"
end
