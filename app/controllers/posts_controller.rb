class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :upvote, :downvote]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.order("created_at DESC")
  end

  def user_posts
    @user = User.find(params[:id])
    @user_posts = Post.where(user_id: params[:id]).order("created_at DESC")
  end

  def media
    @user = User.find(params[:id])
    @user_posts = Post.where(user_id: params[:id]).order("created_at DESC")   
  end

  def likes
    @user = User.find(params[:id])    
    @votes = @user.votes.where(votable_type: "Post").includes(:votable).order("created_at DESC")
    @posts = @votes.collect(&:votable)    
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
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
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
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
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
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

  def upvote
    @post.upvote_by(current_user)
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render :layout => false }
    end  
  end

  def downvote
    @post.downvote_by(current_user)
    respond_to do |format|
        format.html { redirect_to :back }
        format.js { render :layout => false }
    end      
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body, :user_id, :avatar, photographs_attributes: [:id, :chitram, :_destroy])
    end
end
