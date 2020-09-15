# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    field :surveys, resolver: Resolvers::SurveyResolver
    field :profile, resolver: Resolvers::UserResolver
  end
end
