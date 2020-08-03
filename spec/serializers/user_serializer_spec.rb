# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  describe '#avatar_url' do
    it 'returns the avatar url based on the email' do
      user = Fabricate(:user, email: 'hoang.mirs@gmail.com')
      serializer = described_class.new(user)

      expected_url = 'https://api.adorable.io/avatar/hoang.mirs@gmail.com'
      expect(serializer.serializable_hash[:data][:attributes][:avatar_url]).to eq(expected_url)
    end
  end
end
