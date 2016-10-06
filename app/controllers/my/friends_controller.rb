class My::FriendsController < MyController
  before_action :authenticate_user!
  def index
    @friends = current_user.friends
    render json: @friends
  end
end
