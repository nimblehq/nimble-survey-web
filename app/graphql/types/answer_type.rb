# frozen_string_literal: true

module Types
  class AnswerType < Types::Base::Object
    field :id, ID, null: false
    field :text, String, null: true
    field :help_text, String, null: true
    field :input_mask_placeholder, String, null: true
    field :short_text, String, null: true
    field :is_mandatory, Boolean, null: true
    field :is_customer_first_name, Boolean, null: true
    field :is_customer_last_name, Boolean, null: true
    field :is_customer_title, Boolean, null: true
    field :is_customer_email, Boolean, null: true
    field :prompt_custom_answer, Boolean, null: true
    field :weight, String, null: true
    field :display_order, Integer, null: true
    field :display_type, String, null: true
    field :input_mask, String, null: true
    field :date_constraint, String, null: true
    field :default_value, String, null: true
    field :response_class, String, null: true
    field :reference_identifier, String, null: true
    field :score, Integer, null: true
    field :alerts, String, null: true
  end
end
