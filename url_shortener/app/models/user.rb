# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email,
    presence: true,
    uniqueness: true

  has_many :shortened_urls,
    class_name: 'ShortenedUrl',
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visits

  has_many :visited_urls,
    -> { distinct },
    through: :visits,
    source: :url

end
