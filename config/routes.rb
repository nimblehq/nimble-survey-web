Rails.application.routes.draw do
  devise_for :users, skip: %i[sessions passwords registrations]
  devise_scope :user do
    resource :password, only: %i[edit update], as: 'user_password'
  end

  use_doorkeeper do
    # Only use applications_controller to manage OAuth2 applications
    # and mount it outside api/v1 as it has the views

    skip_controllers :tokens, :authorizations, :token_info, :authorized_applications
  end

  resources :graphql, only: :create

  scope :api do
    scope :v1 do
      use_doorkeeper do
        # Only need the tokens_controller for API V1
        controllers tokens: 'api/v1/tokens'

        skip_controllers :applications, :authorizations, :token_info, :authorized_applications
      end
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :passwords, only: :create
        resources :registrations, only: :create
      end

      resources :responses, only: :create
      resources :surveys, only: %i[index show]
      resource :users, only: :show, path: :me
    end

    namespace :docs do
      get '/openapi', to: 'openapi#show'
    end
  end
end
