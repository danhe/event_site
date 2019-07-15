# frozen_string_literal: true

# BaseController
class Api::V1::BaseController < ApplicationController
  attr_accessor :current_user

  rescue_from ActionController::ParameterMissing do |e|
    missing_params!(e)
  end

  rescue_from ActiveRecord::RecordNotFound do
    not_found!
  end

  rescue_from ActiveRecord::RecordInvalid do
    invalid_resource!
  end

  rescue_from ActionController::RoutingError do
    routing_error!
  end

  # rescue_from Exception do |e|
  #   rescue_exception!(e)
  # end

  # When no defined route, redirect here
  def undefined_route
    routing_error!
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank? ? nil : options[:email]
    user = user_email && User.find_by(email: user_email)

    unauthenticated_condition = !(user && ActiveSupport::SecurityUtils.secure_compare(user.token, token))
    return unauthenticated! if unauthenticated_condition

    self.current_user = user
  end

  def check_admin_access!
    return unauthenticated!(errors: 'Only admin has access') unless current_user.admin?
  end

  # =====================
  #  protected methods here
  # =====================
  protected

  # Missing parameters exception
  def missing_params!(e)
    api_error(status: 400, errors: e.message || 'Invalid parameters')
  end

  #  Not Found exception
  def not_found!
    api_error(status: :not_found, errors: 'Not found')
  end

  # Invalid record exception
  def invalid_resource!(errors = [])!
    api_error(status: :unprocessable_entity, errors: errors)
  end

  # Routing error exception
  def routing_error!
    api_error(status: :not_found, errors: 'Invalid/Undefined API')
  end

  # General exception
  def rescue_exception!(exception)
    api_error(status: :error, errors: exception.message)
  end

  def unauthenticated!(errors = 'password wrong')
    api_error(status: 401, errors: errors)
  end

  def api_success(status: :ok, json_data: {})
    render json: json_data, status: status
  end

  def api_error(status: 500, errors: [])
    puts errors.full_messages if errors.respond_to?(:full_messages)

    render json: Api::V1::ErrorSerializer.new(status, errors).as_json, status: status
  end
end
