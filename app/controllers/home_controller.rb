class HomeController < ApplicationController
  layout 'application'
  def index
    @posts = Post.public_posts.eager_load(:user, :sent_to_user)
  end
end
