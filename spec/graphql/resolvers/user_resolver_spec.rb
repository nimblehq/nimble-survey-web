# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::UserResolver do
  it 'returns user profile' do
    query_string = <<-GRAPHQL
      query UserProfile{
        profile {
          id
          email
          avatarUrl
        }
      }
    GRAPHQL

    user = Fabricate(:user, email: 'hoang.mirs@gmail.com')

    result = NimbleSurveyWebSchema.execute(query_string, variables: {}, context: { current_user: user })

    profile = result['data']['profile']

    expect(profile['id']).to eq(user.id.to_s)
    expect(profile['email']).to eq(user.email)
    expect(profile['avatarUrl']).to eq(user.avatar_url)
  end
end
