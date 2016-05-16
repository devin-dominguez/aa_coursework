class GoalCommentsController < ApplicationController
  def create
    @comment = GoalComment.new(params.require(:comment).permit(:body))
    @comment.goal_id = params[:goal_id]
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to goal_url(params[:goal_id])
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to goal_url(params[:goal_id])
    end
  end
end
