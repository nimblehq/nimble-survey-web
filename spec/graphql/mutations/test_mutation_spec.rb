# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::TestMutation do
  it 'returns the greeting' do
    query_string = <<-GRAPHQL
    mutation Test($input: TestMutationInput!) {
      test(input: $input) {
        greeting
      }
    }
    GRAPHQL

    result = NimbleSurveyWebSchema.execute(query_string, variables: { input: { name: 'Hoang' } })

    greeting = result['data']['test']['greeting']

    expect(greeting).to eq('Hello Hoang')
  end
end
