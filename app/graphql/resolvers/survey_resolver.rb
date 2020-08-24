# frozen_string_literal: true

module Resolvers
  class SurveyResolver < BaseResolver
    description 'Survey details'
    argument :id, ID, required: true
    type Types::SurveyType, null: true

    def resolve(id:)
      Survey.find_by(id: id)
    end
  end
end
