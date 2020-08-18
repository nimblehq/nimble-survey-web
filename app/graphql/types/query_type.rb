# frozen_string_literal: true

module Types
  class QueryType < Types::Base::Object
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :surveys, [Types::SurveyType], null: false,
                                         description: 'Survey list'
    def surveys
      Survey.all
    end

    field :me, Types::UserType, null: false, description: 'User information'

    def me
      User.last
    end
  end
end
