class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_gon_stuff

  class NotFoundError < StandardError
  end

  rescue_from NotFoundError do |err|
    Rails.logger.error err.message
    render json: err.message, status: :not_found
  end
  protected

  def set_gon_stuff
    gon.current_user = current_user
  end

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
end
