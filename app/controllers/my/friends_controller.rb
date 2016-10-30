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

  def toggle
    if current_user.friends.pluck(:id).include?(params[:id])
      puts "Deleting friend #{params[:id]}"
      current_user.friendships.find_by(friend_id: params[:id]).destroy
    else
      current_user.friends << User.find_by(id: params[:id])
    end
    render head: :ok, json: true
  end
end
