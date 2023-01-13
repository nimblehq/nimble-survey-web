# frozen_string_literal: true

class ResponseForm < ApplicationForm
  attr_reader :survey, :questions

  validates :survey, presence: { message: :invalid }
  validates :questions, presence: true
  validate :validate_questions, if: -> { survey }

  def initialize(params = {})
    super(nil)

    @survey = Survey.find_by(id: params[:survey_id])
    @questions = params[:questions]
  end

  # @return [Boolean]
  def save
    valid?
  end

  private

  # Check if all submitted questions are contained in survey questions
  def validate_questions
    survey_questions_ids = survey.questions.map(&:id)
    questions_ids = questions.pluck(:id)

    return if (survey_questions_ids & questions_ids).difference(questions_ids).empty?

    errors.add(:questions, :invalid)
  end
end
