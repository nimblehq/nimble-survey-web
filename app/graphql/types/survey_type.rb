# frozen_string_literal: true

module Types
  class SurveyType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :thank_email_above_threshold, String, null: true
    field :thank_email_below_threshold, String, null: true
    field :is_active, Boolean, null: true
    field :cover_image_url, String, null: true
    field :created_at, String, null: true
    field :active_at, String, null: true
    field :inactive_at, String, null: true
    field :type, String, null: true
  end
end
