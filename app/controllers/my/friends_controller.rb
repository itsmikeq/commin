class My::FriendsController < MyController
  before_action :authenticate_user!
  def index
    @friends = current_user.friends
    respond_to do |format|
      format.json {
        render json: @friends
      }
      format.html {
        render 'index'
      }
    end
  end
end
