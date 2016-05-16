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

require 'addressable/uri'
require 'rest-client'

class Cat < ActiveRecord::Base

  after_initialize :set_image

  COLORS = ["black", "white", "grey", "orange"]

  validates :birth_date, presence: :true
  validates :color, presence: :true, inclusion: COLORS
  validates :name, presence: :true
  validates :sex, presence: :true, inclusion: ["M", "F"]
  validates :description, presence: :true
  validates :user_id, presence: true

  has_many :cat_rental_requests, dependent: :destroy
  belongs_to :owner,
    class_name: "User",
    foreign_key: :user_id

  def set_image
    return if self.image_html
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'thecatapi.com',
      port: 80,
      path: '/api/images/git',
      query_values: {
        size: 'small',
        format: 'html'
        }
    ).to_s
    self.image_html = RestClient.get(url)
  end

  def age
    (Date.today - self.birth_date).to_i / 365
  end

  def info
    self.attributes.reject { |k| ["id", "updated_at", "created_at", "image_html"].include?(k) }
  end
end
