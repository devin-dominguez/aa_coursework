# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequestsController < ApplicationController
  before_action :check_ownership, only: [:approve, :deny]
  before_action :user_logged_in?, only: [:new, :create]

  def new
    @rental_request = CatRentalRequest.new
    @rental_request.cat_id = params[:cat_id]
    @rental_request.user_id = @user_id
    render :new
  end

  def create
    @rental_request = CatRentalRequest.new(request_params)
    if @rental_request.save
      redirect_to cat_url(@rental_request.cat_id)
    else
      render text: @rental_request.errors.full_messages
    end
  end

  def approve
    @rental_request = current_rental
    @rental_request.approve!
    redirect_to cat_url(@rental_request.cat_id)
  end

  def deny
    @rental_request = current_rental
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat_id)
  end

  def request_params
    params.require(:request).permit(:cat_id, :start_date, :end_date, :user_id)
  end

  def current_rental
    CatRentalRequest.find_by(id: params[:id])
  end

  private

  def user_logged_in?
    unless current_user
      redirect_to new_session_url
    else
      @user_id = current_user.id
    end
  end

  def check_ownership
    redirect_to cat_url(current_rental.cat_id) unless cat_belongs_to_user?
  end

  def cat_belongs_to_user?
    if current_user.nil?
      flash[:errors] = ["Not logged in"]
      return false
    end

    unless current_user.cats.pluck(:id).include?(current_rental.cat_id)
      flash[:errors] = ["Not your cat"]
      nil
    else
      true
    end
  end
end
