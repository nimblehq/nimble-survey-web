# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Resolvers::SurveyResolver do
  context 'given no pagination params' do
    it 'returns all surveys' do
      query_string = <<~GRAPHQL
        query Surveys {
          surveys {
            totalCount
            edges {
              node {
                id
                title
                description
                questions {
                  id
                }
              }
            }
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      surveys = result['data']['surveys']
      expect(surveys['totalCount']).to eq(20)
      expect(surveys['edges']).to be_an(Array)
      expect(surveys['edges'].size).to eq(20)
    end

    it 'returns the requested fields' do
      query_string = <<~GRAPHQL
        query Surveys {
          surveys {
            totalCount
            edges {
              node {
                id
                title
                description
                questions {
                  id
                }
              }
            }
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      surveys = result['data']['surveys']['edges']
      first_survey = surveys.first['node']

      expect(first_survey['id']).to be_present
      expect(first_survey['title']).to be_present
      expect(first_survey['description']).to be_present
      expect(first_survey['questions']).to be_an(Array)
    end
  end

  context 'given pagination params' do
    it 'returns the correct requested surveys' do
      query_string = <<~GRAPHQL
        query Surveys {
          surveys(first: 2) {
            totalCount
            edges {
              node {
                id
                title
                description
                questions {
                  id
                }
              }
            }
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      surveys = result['data']['surveys']
      expect(surveys['totalCount']).to eq(20)
      expect(surveys['edges']).to be_an(Array)
      expect(surveys['edges'].size).to eq(2)
    end

    it 'returns the requested fields' do
      query_string = <<~GRAPHQL
        query Surveys {
          surveys {
            totalCount
            edges {
              node {
                id
                title
                description
                questions {
                  id
                }
              }
            }
          }
        }
      GRAPHQL

      result = NimbleSurveyWebSchema.execute(query_string, variables: {})

      surveys = result['data']['surveys']['edges']
      first_survey = surveys.first['node']

      expect(first_survey['id']).to be_present
      expect(first_survey['title']).to be_present
      expect(first_survey['description']).to be_present
      expect(first_survey['questions']).to be_an(Array)
    end
  end
end
