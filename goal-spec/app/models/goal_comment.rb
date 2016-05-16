class GoalComment < ActiveRecord::Base
  belongs_to :goal

  belongs_to :author,
  foreign_key: :author_id,
  primary_key: :id,
  class_name: :User
end
