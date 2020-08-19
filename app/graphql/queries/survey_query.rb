# frozen_string_literal: true

module Queries
  class SurveyQuery < BaseQuery
    type [Types::SurveyType], null: false
    description 'Survey list'

    def resolve
      Survey.all
    end
  end
end
