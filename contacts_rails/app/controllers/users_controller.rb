# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string
#

class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
      json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    render json: User.find(id)
  end

  def update
    @user = User.find( id)
    if @user.update( user_params )
      render json: @user
    else
      render(
      json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @user = User.find( id )
    @user.destroy
    render text: "#{user.username} is no more!"
  end

  private

  def user_params
    params[:user].permit(:username)
  end
end
