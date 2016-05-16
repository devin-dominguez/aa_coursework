require_relative 'table_manifest'


class QuestionLikes < ModelBase
  attr_accessor :user_id, :question_id, :liked

  # def self.all
  #   question = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       question_likes
  #   SQL
  #   question.map { |question_info| self.new(question_info) }
  # end

  # def self.create(options)
  #   new_like = QuestionLikes.new(options)
  #   new_like.save
  #   new_like
  # end

  # def self.find_by_id(id)
  #   question_info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
  #     SELECT
  #       *
  #     FROM
  #       question_likes
  #     WHERE
  #       id = :id
  #   SQL
  #
  #   raise "reply not found" if question_info.empty?
  #   self.new(question_info[0])
  # end

  def self.likers_for_question_id(question_id)
    users = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        *
      FROM
        users
        JOIN
          question_likes ON users.id = question_likes.user_id
      WHERE
        question_id = :question_id
    SQL

    users.map { |user_info| User.new(user_info) }
  end

  def self.liked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = :user_id AND liked = 'TRUE'
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def self.disliked_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.user_id = :user_id AND liked = 'FALSE'
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def self.num_likes_for_question_id(question_id)
    count = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        COUNT(*) AS likes
      FROM
        users
        JOIN
          question_likes ON users.id = question_likes.user_id
      WHERE
        question_id = :question_id
    SQL

    count.first['likes']
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        *
      FROM
        questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
      WHERE
        liked = 'TRUE'
      GROUP BY
        question_id
      ORDER BY
        COUNT(DISTINCT(*)) DESC
      LIMIT :n
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def self.most_disliked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        *
      FROM
        questions
        JOIN
          question_likes ON questions.id = question_likes.question_id
      WHERE
        liked = 'FALSE'
      GROUP BY
        question_id
      ORDER BY
        COUNT(DISTINCT(*)) DESC
      LIMIT :n
    SQL

    questions.map { |question_info| Questions.new(question_info) }
  end

  def initialize(options)
    @id, @user_id, @question_id, @liked = options.values_at('id', 'user_id', 'question_id', 'liked')
  end

  def save
    raise "already in db" unless @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, question_id: @question_id, user_id: @user_id, liked: @liked)
      INSERT INTO
        question_likes (question_id, user_id, liked)
      VALUES
        (:question_id, :user_id, :liked)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "not in db" if @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, id: @id, question_id: @question_id, user_id: @user_id, liked: @liked)
      UPDATE
        question_likes
      SET
        question_id = :question_id, user_id = :user_id, liked = :liked
      WHERE
        id = :id
      SQL

  end
end
