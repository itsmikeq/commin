class UsersController < ApplicationController
  def public_users
    render json: User.public_users.order("created_at desc").limit(10)
  end
end