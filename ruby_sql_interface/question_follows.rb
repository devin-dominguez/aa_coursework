require_relative 'table_manifest'


class QuestionFollows < ModelBase
  attr_accessor :question_id, :user_id

  # def self.all
  #   questions = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       questions_follows
  #   SQL
  #   questions.map { |question_info| self.new(question_info) }
  # end

  # def self.create(options)
  #   new_follower = QuestionsFollows.new(options)
  #   new_follower.save
  #   new_follower
  # end

  # def self.find_by_id(id)
  #   question_info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
  #     SELECT
  #       *
  #     FROM
  #       questions_follows
  #     WHERE
  #       id = :id
  #   SQL
  #
  #   raise "question not found" if question_info.empty?
  #   self.new(question_info[0])
  # end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        *
      FROM
        users
      JOIN
        questions_follows ON users.id = questions_follows.user_id
      WHERE
        questions_follows.question_id = :question_id
    SQL

    followers.map { |user_info| User.new(user_info) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        questions
      JOIN
        questions_follows ON questions.id = questions_follows.question_id
      WHERE
        questions_follows.user_id = :user_id
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        *
      FROM
        questions
        JOIN
          questions_follows ON questions.id = questions_follows.question_id
      GROUP BY
        question_id
      ORDER BY
        COUNT(*) DESC
      LIMIT :n
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def initialize(options)
    @id, @question_id, @user_id = options.values_at('id', 'question_id', 'user_id')
  end

  def save
    raise "already in db" unless @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, question_id: @question_id, user_id: @user_id)
      INSERT INTO
        questions_follows (question_id, user_id)
      VALUES
        (:question_id, :user_id)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "not in db" if @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, id: @id, question_id: @question_id, user_id: @user_id)
      UPDATE
        questions_follows
      SET
        question_id = :question_id, user_id = :user_id
      WHERE
        id = :id
      SQL

  end
end
