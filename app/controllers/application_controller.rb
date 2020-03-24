# frozen_string_literal: true

class ApplicationController < ActionController::API
  WillPaginate.per_page = 10

  rescue_from ActiveRecord::RecordNotFound do |_e|
    render_json_error :not_found, 'Resource not found'
  end

  def render_json_error(status, message)
    render json: { message: message }, status: status
  end

  def render_json_validation_error(resource)
    render json: { errors: resource.errors }, status: :bad_request
  end
end
