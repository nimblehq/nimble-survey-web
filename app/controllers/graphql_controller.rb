# frozen_string_literal: true

class GraphqlController < ActionController::API
  include API::V1::DoorkeeperAuthentication

  def create
    render json: result
  end

  private

  def result
    variables = ensure_hash(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user
    }
    NimbleSurveyWebSchema.execute(query, variables: variables, context: context, operation_name: operation_name)
  end

  # Handle form data, JSON body, or a blank value
  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      ambiguous_param.present? ? ensure_hash(JSON.parse(ambiguous_param)) : {}
    when Hash, ActionController::Parameters
      ambiguous_param
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end
end
