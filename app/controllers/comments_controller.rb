class CommentsController < ApplicationController

	def create
		collection_user = User.find(params[:comment][:collection_user])
		comment = collection_user.collection.comments.create(comment_params) if collection_user.collection
		unless comment && comment.save
			flash[:danger] = "Something went wrong. Your comment wasn't posted."
		end
		redirect_to collection_user
	end

	def destroy
		user = User.find(params[:user_id])
		comment = Comment.find(params[:id])
		comment.destroy
		flash[:success] = "Comment deleted."
		redirect_to user
	end

	private

		def comment_params
			params.require(:comment).permit(:author_id, :author, :comment)
		end
end
