class CommentsController < ApplicationController
	before_action :authenticate_user!
	def create 
		@post = Post.find(params[:post_id])
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
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		respond_to do |format|
       		format.html { redirect_to :back }
        	format.js { render :layout => false }
    	end 
	end

	 def upvote
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])	 	
    	@comment.upvote_by(current_user)
		respond_to do |format|
       		format.html { redirect_to :back }
        	format.js { render :layout => false }
    	end  
     end

  	def downvote
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.downvote_by(current_user)
		respond_to do |format|
       		format.html { redirect_to :back }
        	format.js { render :layout => false }
    	end 		
  	end
end
