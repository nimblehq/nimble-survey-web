# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::SurveyResolver do
  context 'given a valid survey ID' do
    it 'returns survey details' do
      query_string = <<~GRAPHQL
        query SurveyDetails {
          survey(id: "d5de6a8f8f5f1cfe51bc") {
              id
              title
              description
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      survey = result['data']['survey']
      expect(survey['id']).to be_present
      expect(survey['title']).to be_present
      expect(survey['description']).to be_present
    end
  end

  context 'given an invalid survey ID' do
    it 'returns null' do
      query_string = <<~GRAPHQL
        query SurveyDetails {
          survey(id: "invalid") {
              id
              title
              description
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      survey = result['data']['survey']
      expect(survey).to be_nil
    end
  end
end
