class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = current_user.all_posts.order("created_at desc").page(params[:page]).per(100)
    # @posts = Post.where.not(sent_to_user: nil).first(1)
  end

  def by_user
    username = if params[:username].match(/.json/)
                 params[:username].split('.json').first
               else
                 params[:username]
               end
    respond_to do |format|
      format.json {
        @posts = User.find_by(username: username).public_posts
        render 'posts/index', format: :json
      }
      format.html {
        render 'posts/by_user'
      }
    end

  end
  
  def by_topic
    topic = if params[:topic].match(/.json/)
                 params[:topic].split('.json').first
               else
                 params[:topic]
               end
    respond_to do |format|
      format.json {
        @posts = Topic.find_by(tag: topic).posts.public_posts
        render 'posts/index', format: :json
      }
      format.html {
        render 'posts/by_user'
      }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to :back, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = current_user.posts.find_by(id: params[:id]) || raise(NotFoundError.new("Cannot find post #{params[:id]}"))
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:body, :user_id, :reply_post_id)
  end
end
