require_relative 'table_manifest'


class Replies < ModelBase
  attr_accessor :question_id, :parent_reply_id, :user_id, :body

  # def self.all
  #   reply = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       replies
  #   SQL
  #   reply.map { |reply_info| self.new(reply_info) }
  # end

  # def self.create(options)
  #   new_reply = Replies.new(options)
  #   new_reply.save
  #   new_reply
  # end

  # def self.find_by_id(id)
  #   reply_info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
  #     SELECT
  #       *
  #     FROM
  #       replies
  #     WHERE
  #       id = :id
  #   SQL
  #
  #   raise "reply not found" if reply_info.empty?
  #   self.new(reply_info[0])
  # end

  def self.find_by_user_id(user_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = :user_id
    SQL

    raise "no replies found" if replies.empty?
    replies.map { |reply_info| self.new(reply_info) }
  end

  def self.find_by_question_id(question_id)
    replies = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = :question_id
    SQL

    raise "no replies found" if replies.empty?
    replies.map { |reply_info| self.new(reply_info) }
  end

  def initialize(options)
    @id, @question_id, @parent_reply_id, @user_id, @body = options.values_at('id', 'question_id', 'parent_reply_id', 'user_id', 'body')
  end

  def parent_reply
    Replies.find_by_id(@parent_reply_id)
  end

  def child_replies
    replies = QuestionsDatabase.instance.execute(<<-SQL, id: @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = :id
    SQL

    raise "no replies found" if replies.empty?
    replies.map { |reply_info| Replies.new(reply_info) }
  end

  def save
    raise "already in db" unless @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, question_id: @question_id, parent_reply_id: @parent_reply_id, user_id: @user_id, body: body)
      INSERT INTO
        questions_follows (question_id, parent_reply_id, user_id, body)
      VALUES
        (:question_id, :parent_reply_id, :user_id, :body)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "not in db" if @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, id: @id, question_id: @question_id, parent_reply_id: @parent_reply_id, user_id: @user_id, body: body)
      UPDATE
        questions_follows
      SET
        question_id = :question_id, parent_reply_id = :parent_reply_id, user_id = :user_id, body = :body
      WHERE
        id = :id
      SQL

  end
end
