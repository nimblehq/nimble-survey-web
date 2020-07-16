# frozen_string_literal: true

Fabricator(:user, from: 'User') do
  email { FFaker::Internet.email }
  password 'password'
end
