# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  after_initialize :ensure_session_token
  attr_reader :password

  validates :user_name, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  has_many :cats, dependent: :destroy
  has_many :rentals, dependent: :destroy,
    class_name: "CatRentalRequest",
    foreign_key: :user_id


  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw).to_s
  end

  def is_password?(pw)
    pw_object = BCrypt::Password.new(self.password_digest)
    pw_object.is_password?(pw)
  end

  def self.find_by_credentials(user_name, pw)
    user = User.find_by(user_name: user_name)
    return nil if user.nil?
    user.is_password?(pw) ? user : nil
  end
end
