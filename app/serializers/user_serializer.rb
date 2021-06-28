# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :email, :name, :avatar_url
end
