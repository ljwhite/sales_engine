Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
      end
      namespace :items do
        get '/find', to: 'search#show'
      end
      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
      get '/merchants/:id/items', to: 'merchant_items#index'
      get '/items/:id/merchant', to: 'merchant_items#show'
    end
  end
end
