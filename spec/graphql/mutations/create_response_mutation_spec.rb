# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateResponseMutation do
  context 'given valid attributes' do
    it 'returns success' do
      variables = {
        input: {
          response: {
            surveyId: 'd5de6a8f8f5f1cfe51bc',
            questions: [
              {
                id: '940d229e4cd87cd1e202'
              },
              {
                id: 'c3a9b8ce5c2356010703',
                answers: [
                  {
                    id: '2a49e148c5b170aca804',
                    answer: 'My answer'
                  }
                ]
              }
            ]
          }
        }
      }

      result = NimbleSurveyWebSchema.execute(create_response_query_string, variables: variables)

      create_response = result['data']['createResponse']

      expect(create_response['success']).to eq(true)
    end
  end

  context 'given invalid attributes' do
    it 'returns error message' do
      variables = {
        input: {
          response: {
            surveyId: 'd5de6a8f8f5f1cfe51bc',
            questions: []
          }
        }
      }

      result = NimbleSurveyWebSchema.execute(create_response_query_string, variables: variables)

      create_response = result['data']['createResponse']
      errors = result['errors']

      expect(create_response).to be_nil
      expect(errors[0]['message']).to eq("Questions can't be blank")
    end
  end

  private

  def create_response_query_string
    <<-GRAPHQL
      mutation CreateResponse($input: CreateResponseMutationInput!){
        createResponse(input: $input){
          success
        }
      }
    GRAPHQL
  end
end
