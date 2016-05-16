require_relative 'table_manifest'

class User < ModelBase
  attr_accessor :fname, :lname

  # def self.all
  #   users = QuestionsDatabase.instance.execute(<<-SQL)
  #     SELECT
  #       *
  #     FROM
  #       users
  #   SQL
  #   users.map { |user_info| self.new(user_info) }
  # end

  # def self.create(options)
  #   new_user = User.new(options)
  #   new_user.save
  #   new_user
  # end

  # def self.find_by_id(id)
  #   user_info = QuestionsDatabase.instance.execute(<<-SQL, id: id)
  #     SELECT
  #       *
  #     FROM
  #       users
  #     WHERE
  #       id = :id
  #   SQL
  #
  #   raise "user not found" if user_info.empty?
  #   self.new(user_info[0])
  # end

  def self.find_by_name(fname, lname)
    question_info = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = :fname AND lname = :lname
    SQL

    raise "question not found" if question_info.empty?
    self.new(question_info[0])
  end

  def initialize(options)
    @id, @fname, @lname = options.values_at('id', 'fname', 'lname')
  end

  def authored_questions
    Questions.find_by_author_id(@id)
  end

  def authored_replies
    Replies.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollows.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLikes.liked_questions_for_user_id(@id)
  end

  def average_positive_karma
    karma = QuestionsDatabase.instance.execute(<<-SQL, auth_id: @id)
      SELECT
        CAST((COUNT(DISTINCT(question_likes.liked)) / COUNT(*)) AS FLOAT) AS avg
      FROM
        questions
        LEFT JOIN
          question_likes ON questions.id = question_likes.question_id
      WHERE
        question_likes.liked = 'TRUE' AND questions.auth_id = :auth_id
      GROUP BY
        questions.id
    SQL

    raise 'no questions for this user' if karma.empty?
    karma.first['avg']
  end

  def save
    raise "already in db" unless @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, fname: @fname, lname: @lname)
      INSERT INTO
        users (fname, lname)
      VALUES
        (:fname, :lname  )
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "not in db" if @id.nil?

    QuestionsDatabase.instance.execute(<<-SQL, id: @id, fname: @fname, lname: @lname)
      UPDATE
        users
      SET
        fname = :fname, lname = :lname
      WHERE
        id = :id
      SQL

  end

end
