# frozen_string_literal: true

class NimbleSurveyWebSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
