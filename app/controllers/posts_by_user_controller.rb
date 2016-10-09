class PostsByUserController < ApplicationController

  def index
    username = if params[:username].match(/.json$/)
                 params[:username].split('.json').first
               else
                 params[:username]
               end
    respond_to do |format|
      format.json {
        # TODO: response based on friendship
        # TODO: If friend, then public + private + associated direct posts
        @posts = User.find_by(username: username).public_posts.includes(:reply_posts)
        render 'posts/index', format: :json
      }
      format.html {
        render 'posts/by_user'
      }
    end

  end

end