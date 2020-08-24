# frozen_string_literal: true

module Resolvers
  class SurveysResolver < BaseResolver
    description 'Survey list'
    type [Types::SurveyType], null: false

    def resolve
      Survey.all
    end
  end
end
