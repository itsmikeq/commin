class My::PostsController < MyController
  before_action :authenticate_user!

  def index
    @posts = Post.search_by(user_id: current_user.id)
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
    @posts = Post.search_by(sent_to_user_id: current_user.id)
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
