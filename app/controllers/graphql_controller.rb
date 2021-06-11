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

  def current_user
    return User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token && !doorkeeper_token.expired?

    raise Doorkeeper::Errors::DoorkeeperError, 'Invalid access token'
  end

  # :reek:FeatureEnvy
  def doorkeeper_unauthorized_render_options(error: nil)
    return unless error

    {
      json: {
        errors: [
          {
            message: error.description,
            extensions: {
              code: error.name,
              state: error.state
            }
          }
        ]
      }
    }
  end
end
