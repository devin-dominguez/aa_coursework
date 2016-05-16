# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :body, presence: true
  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    foreign_key: :question_id,
    primary_key: :id

  belongs_to :poll,
    class_name: "Poll",
    foreign_key: :poll_id,
    primary_key: :id

  has_many :responses,
    through: :answer_choices,
    source: :responses

    def results
      a = self.class.find_by_sql(<<-SQL)
        SELECT
          answer_choices.answer, COUNT(*)
        FROM
          answer_choices
          JOIN
            responses ON answer_choices.id = responses.answer_choice_id
        WHERE
          answer_choices.question_id = #{self.id}
        GROUP BY
          answer_choices.id

      SQL
      puts a

    end

    def results_the_bad_way
      result_hash = {}

      self.answer_choices.each do |ac|
        result_hash[ac.answer] = ac.responses.count
      end

      result_hash
    end

    def results_the_better_way
      result_hash = {}
      self.answer_choices.includes(:responses).each do |ac|
        result_hash[ac.answer] = ac.responses.length
      end

      result_hash
    end
end
