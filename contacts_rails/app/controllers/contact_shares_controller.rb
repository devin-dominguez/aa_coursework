# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactSharesController < ApplicationController
  def create
    @contact_share = ContactShare.new(contact_share_params)
    if @contact_share.save
      render json: @contact_share
    else
      render(
        json: @contact_share.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact_share = ContactShare.find( id )
    @contact_share.destroy
    render text: "#{contact_share.username} is no more!"
  end

  private

  def contact_share_params
    params[:contact_share].permit(:contact_id, :user_id)
  end

end
