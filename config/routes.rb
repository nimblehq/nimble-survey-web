Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/registrations#edit"
  end

  scope :api do
    scope :v1 do
      use_doorkeeper do
        skip_controllers :applications, :authorizations, :token_info
      end
    end
  end
end
