class PostsByTagController < ApplicationController

  def posts
    tag = if params[:tag].match(/.json/)
            params[:tag].split('.json').first
          else
            params[:tag]
          end
    respond_to do |format|
      format.json {
        @posts = Topic.find_by(tag: tag).posts.public_posts.uniq rescue []
        render 'posts/index', format: :json
      }
      format.html {
        render 'posts_by_tag/index'
      }
    end

  end

end