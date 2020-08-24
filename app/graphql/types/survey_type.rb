# frozen_string_literal: true

module Types
  class SurveyType < Types::Base::Object
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :thank_email_above_threshold, String, null: true
    field :thank_email_below_threshold, String, null: true
    field :is_active, Boolean, null: true
    field :cover_image_url, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :active_at, GraphQL::Types::ISO8601DateTime, null: true
    field :inactive_at, GraphQL::Types::ISO8601DateTime, null: true
    field :survey_type, String, null: true, method: :type
    field :questions, [Types::QuestionType], null: true
  end
end
