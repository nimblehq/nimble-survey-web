# frozen_string_literal: true

module Mutations
  class CreateResponseMutation < BaseMutation
    description "Create a new survey's response"

    argument :response, Types::Inputs::ResponseInput, required: true

    field :survey, Types::SurveyType, null: false
    field :questions, [Types::QuestionType], null: false

    def resolve(response:)
      response_form = ResponseForm.new(response)

      raise(GraphQL::ExecutionError, response_form.errors.full_messages.to_sentence) unless response_form.save

      {
        survey: response_form.survey,
        questions: response_form.questions
      }
    end
  end
end
