class SubsController < ApplicationController
  def index
    @subs = Sub.all
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator = current_user
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:sub_creation_errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
  end

  def show
    @sub = Sub.find_by(id: params[:id])
  end

  def update
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
