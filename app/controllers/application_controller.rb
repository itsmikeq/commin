class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class NotFoundError < StandardError
  end

  rescue_from NotFoundError do |err|
    Rails.logger.error err.message
  end
  protected

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])
  # end

  def signed_in?
    !!current_user
  end
  helper_method :signed_in?

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
end
