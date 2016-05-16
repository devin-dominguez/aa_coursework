class Enrollment < ActiveRecord::Base
  belongs_to :student,
    class_name: :User,
    foreign_key: :student_id,
    primary_key: :id

  belongs_to :course
end
