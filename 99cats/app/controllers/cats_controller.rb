# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             default("No description given"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image_html  :string
#

class CatsController < ApplicationController
  before_action :check_ownership, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner = current_user
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  private

  def cat_belongs_to_user?
    if current_user.nil?
      flash[:errors] = ["Not logged in"]
      return false
    end
    
    @cat = current_user.cats.find_by_id(params[:id])
    if @cat.nil?
      flash[:errors] = ["Not your cat"]
      nil
    else
      true
    end
  end

  def check_ownership
    redirect_to cat_url(params[:id]) unless cat_belongs_to_user?
  end

  def current_cat
    Cat.find_by(id: params[:id])
  end

  def cat_params
    params.require(:cat).permit(:name, :birth_date, :color, :sex, :description)
  end
end
