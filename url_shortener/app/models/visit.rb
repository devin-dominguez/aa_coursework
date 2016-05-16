# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  url_id     :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Visit < ActiveRecord::Base
  validates :url_id, presence: true
  validates :user_id, presence: true

  belongs_to :user

  belongs_to :url,
  class_name: "ShortenedUrl",
  foreign_key: :url_id,
  primary_key: :id


  def self.record_visit!(user, shortened_url)
      Visit.create!(url: shortened_url, user: user)
  end

end
