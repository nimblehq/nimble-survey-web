# frozen_string_literal: true

module Mutations
  class CreateResponseMutation < BaseMutation
    description "Create a new survey's response"

    argument :response, Types::Inputs::ResponseInput, required: true

    field :success, Boolean, null: false

    def resolve(response:)
      response_form = ResponseForm.new(response)

      raise(GraphQL::ExecutionError, response_form.errors.full_messages.to_sentence) unless response_form.save

      {
        success: true
      }
    end
  end
end
