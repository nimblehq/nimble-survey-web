# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    field :surveys, resolver: Queries::SurveyQuery
  end
end
