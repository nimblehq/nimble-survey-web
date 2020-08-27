# frozen_string_literal: true

module Types
  module Inputs
    class AnswerInput < Types::Base::InputObject
      description 'Attributes for answer'

      argument :id, ID, required: true
      argument :answer, String, required: false
    end
  end
end
