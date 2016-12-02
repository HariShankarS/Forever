class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, except: [:create]
  def create 
    @comment = @post.comments.new(params[:comment].permit(:cmnt, :user_id, :post_id))
    @comment.user = current_user
    @comment.save
    @comments = @post.comments.reload
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end  
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end 
  end

  def upvote
    @comment.upvote_by(current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end  
  end

  def downvote
    @comment.downvote_by(current_user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end 		
  end
end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end