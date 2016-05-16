# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#

class Response < ActiveRecord::Base
  validates :user_id, presence: true, uniqueness: {scope: :answer_choice_id}
  validates :answer_choice_id, presence: true
  validate :multiple_user_responses_not_allowed
  validate :author_can_not_respond_to_own_poll

  belongs_to :respondent,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  has_one :question,
    through: :answer_choice,
    source: :question

    def sibling_responses
      self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?()
      self.sibling_responses.exists?(user_id: self.user_id)
    end

    def answering_own_poll?
      self.question.poll.author_id == self.user_id
    end


    private

    def multiple_user_responses_not_allowed
      if self.respondent_already_answered?
        errors[:response] << "can't be from same author for one question."
      end
    end

    def author_can_not_respond_to_own_poll
      if self.answering_own_poll?
        errors[:response] << "can't be from author of poll"
      end
    end

end
