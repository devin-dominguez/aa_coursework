# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  email      :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ContactsController < ApplicationController
  def index
    user = User.find( params[:user_id] )
    @contacts = user.contacts
    @shared_contacts = user.shared_contacts

    render json: @contacts + @shared_contacts
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render(
        json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    render json: Contact.find(id)
  end

  def update
    @contact = Contact.find( id)
    if @contact.update( contact_params )
      render json: @contact
    else
      render(
      json: @contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @contact = Contact.find( id )
    @contact.destroy
    render text: "#{contact.username} is no more!"
  end

  private

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end

end
