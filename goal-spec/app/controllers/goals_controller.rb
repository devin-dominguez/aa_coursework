# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  body       :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  private    :boolean          default(TRUE), not null
#

class GoalsController < ApplicationController

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = params[:user_id]

    if @goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :private)
  end
end
