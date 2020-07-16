# frozen_string_literal: true

RSpec.configure do |config|
  # For user authentication
  config.before(:example, auth: :user_token) do
    user = Fabricate(:user)
    access_token = Fabricate(:access_token, resource_owner_id: user.id)

    allow(controller).to receive(:doorkeeper_token) { access_token }
    request.headers['Content-Type'] = 'application/json'
  end
end
