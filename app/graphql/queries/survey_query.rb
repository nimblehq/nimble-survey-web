# frozen_string_literal: true

module Queries
  class SurveyQuery < BaseQuery
    description 'Survey list'

    type [Types::SurveyType], null: false

    def resolve
      Survey.all
    end
  end
end
