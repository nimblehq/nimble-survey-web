# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserDecorator do
  describe '#avatar_url' do
    it 'returns the avatar url based on the email' do
      user = Fabricate(:user, email: 'dev@nimblehq.co')
      decorator = described_class.new(user)

      expected_url = 'https://secure.gravatar.com/avatar/6733d09432e89459dba795de8312ac2d'
      expect(decorator.avatar_url).to eq(expected_url)
    end
  end
end
