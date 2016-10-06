class My::PostsController < MyController
  before_action :authenticate_user!

  def index
    @posts = current_user.posts
    respond_to do |format|
      format.html {
        render 'my/posts/index'
      }
      format.json {
        render 'posts/index'
      }
    end

  end

  def direct
    @posts = current_user.received_messages
    respond_to do |format|
      format.html {
        render 'my/posts/direct'
      }
      format.json {
        render 'posts/index'
      }
    end
  end
end
