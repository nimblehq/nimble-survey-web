# frozen_string_literal: true

module Types
  module Inputs
    class QuestionInput < Types::Base::InputObject
      description 'Attributes for question'

      argument :id, ID, required: true
      argument :answers, [Types::Inputs::AnswerInput], required: false
    end
  end
end
