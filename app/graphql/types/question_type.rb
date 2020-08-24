# frozen_string_literal: true

module Types
  class QuestionType < Types::Base::Object
    field :id, ID, null: false
    field :text, String, null: false
    field :help_text, String, null: true
    field :display_order, Integer, null: true
    field :short_text, String, null: true
    field :pick, String, null: true
    field :display_type, String, null: true
    field :is_mandatory, Boolean, null: true
    field :correct_answer_id, String, null: true
    field :facebook_profile, String, null: true
    field :twitter_profile, String, null: true
    field :image_url, String, null: true
    field :cover_image_url, String, null: true
    field :cover_image_opacity, Float, null: true
    field :cover_background_color, String, null: true
    field :is_shareable_on_facebook, Boolean, null: true
    field :is_shareable_on_twitter, Boolean, null: true
    field :font_face, String, null: true
    field :font_size, String, null: true
    field :tag_list, String, null: true
    field :answers, [Types::AnswerType], null: true
  end
end
