# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::SurveyResolver do
  it 'returns all surveys' do
    query_string = <<~GRAPHQL
      query Surveys {
        surveys {
            id
            title
            description
        }
      }
    GRAPHQL

    result = NimbleSurveyWebSchema.execute(query_string, variables: {})

    surveys = result['data']['surveys']
    expect(surveys).to be_an(Array)

    survey = surveys.first
    expect(survey['id']).to be_present
    expect(survey['title']).to be_present
    expect(survey['description']).to be_present
  end
end
