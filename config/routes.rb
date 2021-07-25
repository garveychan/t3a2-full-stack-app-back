Rails.application.routes.draw do
  defaults format: :json do
    devise_for \
      :users,
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

    resources :members, only: %i[index create]
    scope :members do
      get '/form', to: 'members#new'
      get '/show', to: 'members#show'
      put '/update', to: 'members#update'
      delete '/delete', to: 'members#destroy'
    end

    scope :payments do
      get '/checkout', to: 'payments#new'
      get '/manage', to: 'payments#edit'
    end
  end
end
