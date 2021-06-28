# frozen_string_literal: true

module Types
  class UserType < Types::Base::Object
    field :id, ID, null: false
    field :email, String, null: false
    field :name, String, null: false
    field :avatar_url, String, null: false
  end
end
