# frozen_string_literal: true

module Types
  module Inputs
    class ResponseInput < Types::Base::InputObject
      description "Attributes for creating a survey's response"

      argument :survey_id, ID, required: true
      argument :questions, [Types::Inputs::QuestionInput], required: true
    end
  end
end
