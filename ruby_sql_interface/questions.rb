require_relative 'table_manifest'

class Questions < ModelBase
  attr_accessor :title, :body, :auth_id

  # def self.all
  #   questions = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       questions
  #   SQL
  #   questions.map { |question_info| self.new(question_info) }
  # end

  # def self.create(options)
  #   new_question = Question.new(options)
  #   new_question.save
  #   new_question
  # end

  # def self.find_by_id(id)
  #   question_info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
  #     SELECT
  #       *
  #     FROM
  #       questions
  #     WHERE
  #       id = :id
  #   SQL
  #
  #   raise "question not found" if question_info.empty?
  #   self.new(question_info[0])
  # end

  def self.find_by_author_id(auth_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, auth_id: auth_id)
      SELECT
        *
      FROM
        questions
      WHERE
        auth_id = :auth_id
    SQL

    raise "question not found" if questions.empty?
    questions.map { |question_info| self.new(question_info) }
  end

  def self.most_followed(n)
    QuestionFollows.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLikes.most_liked_questions(n)
  end

  def self.most_disliked(n)
    QuestionLikes.most_disliked_questions(n)
  end

  def initialize(options)
    @id, @title, @body, @auth_id = options.values_at('id', 'title', 'body', 'auth_id')
  end

  def author
    User.find_by_id(@auth_id)
  end

  def replies
    Replies.find_by_question_id(@id)
  end

  def followers
    QuestionFollows.followers_for_question_id(@id)
  end

  def likers
    QuestionLikes.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLikes.num_likes_for_question_id(@id)
  end

  def save
    raise "already in db" unless @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, title: @title, body: @body, auth_id: @auth_id)
      INSERT INTO
        questions (title, body, auth_id)
      VALUES
        (:title, :body, :auth_id)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "not in db" if @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, id: @id, title: @title, body: @body, auth_id: @auth_id)
      UPDATE
        questions
      SET
        title = :title, body = :body, auth_id = :auth_id
      WHERE
        id = :id
      SQL

  end

end
