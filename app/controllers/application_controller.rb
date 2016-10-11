class ApplicationController < ActionController::Base
  include ApplicationHelper
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
    gon.current_user   = current_user
    gon.body_data_page = body_data_page
    gon.tags_url_base  = '/posts/by/tag'
    gon.ws_url         = 'ws://localhost:3000/cable'
  end

  def signed_in?
    !!current_user
  end

  helper_method :signed_in?

  def current_user=(user)
    @current_user     = user
    session[:user_id] = user.nil? ? nil : user.id
  end
end
