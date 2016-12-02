class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy, :upvote, :downvote]
  before_action :find_user, only: [:user_posts, :media, :likes]

  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
  end

  def user_posts
    @user_posts = Post.where(user_id: params[:id]).order("created_at DESC")
  end

  def media
    @user_posts = Post.where(user_id: params[:id]).order("created_at DESC")   
  end

  def likes
    @votes = @user.votes.where(votable_type: "Post").includes(:votable).order("created_at DESC")
    @posts = @votes.collect(&:votable)    
  end

  def shows
  end

  def new
    @post = Post.new
  end

  def edit
  end

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
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body, :user_id, :avatar, photographs_attributes: [:id, :chitram, :_destroy])
    end

    def find_user
      @user = User.find(params[:id])
    end
end
