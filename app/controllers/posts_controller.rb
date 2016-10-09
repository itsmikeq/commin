class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = if current_user
               current_user.all_posts
             else
               Post.public_posts
             end.order("created_at desc").page(params[:page]).per(100)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    respond_to do |format|
      format.json {
        # TODO: response based on friendship
        # TODO: If friend, then public + private + associated direct posts
        if @post && params[:children]
          @posts = @post.reply_posts.uniq
          render 'posts/index', format: :json
        elsif @post
          @posts = [@post]
          render 'posts/index', format: :json
        else
          @posts = []
          render json: []
        end
      }
      format.html {
        render 'posts/by_user'
      }
    end
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
  # TODO: Filter for current_user access
  def set_post
    @post = Post.find_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:body, :user_id, :reply_post_id)
  end
end
