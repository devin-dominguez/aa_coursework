class UserComment < ActiveRecord::Base
  belongs_to :user

  belongs_to :author,
  foreign_key: :author_id,
  primary_key: :id,
  class_name: :User
end
