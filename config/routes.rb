Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'list_items#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      get '/revenue', to: 'revenue#show'
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :merchants, except: [:new, :edit]
      resources :items, except: [:new, :edit]
      get '/merchants/:id/items', to: 'merchant_items#index'
      get '/items/:id/merchant', to: 'merchant_items#show'
    end
  end
end
