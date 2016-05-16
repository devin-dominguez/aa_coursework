class CommentsController < ApplicationController
  def create
    @comment = UserComment.new(params.require(:comment).permit(:body))
    @comment.user_id = params[:user_id]
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to user_url(params[:user_id])
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(params[:user_id])
    end
  end
end
