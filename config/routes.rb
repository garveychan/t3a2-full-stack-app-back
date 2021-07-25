Rails.application.routes.draw do
  devise_for \
    :users,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }, defaults: { format: :json }

  resources :members do
    # get 'search', on: :collection
    # get 'favourites', to: 'favourites#index', on: :collection
    # post 'favourite', to: 'favourites#create', on: :member
    # delete 'favourite', to: 'favourites#destroy', on: :member
    # resources :products, except: :index do
    #   post 'favourite', to: 'favourites#create', on: :member
    #   delete 'favourite', to: 'favourites#destroy', on: :member
    # end
  end
end
