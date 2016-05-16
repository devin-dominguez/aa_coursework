# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      m.title
    FROM
      movies AS m INNER JOIN castings AS c
      ON
        m.id = c.movie_id
    WHERE
      c.actor_id = (
        SELECT
          id
        FROM
          actors
        WHERE
          name = 'Harrison Ford'
      )
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      m.title
    FROM
      movies AS m INNER JOIN castings AS c
      ON
        m.id = c.movie_id
    WHERE
      c.actor_id = (
        SELECT
          id
        FROM
          actors
        WHERE
          name = 'Harrison Ford'
      ) AND c.ord > 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      m.title, a.name
    FROM
      movies m
    INNER JOIN
      castings c ON m.id = c.movie_id
    INNER JOIN
      actors a ON a.id = c.actor_id
    WHERE
      m.yr = 1962 AND c.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      m.yr, COUNT(m.title)
    FROM
      actors a
    INNER JOIN
      castings c ON a.id = c.actor_id
    INNER JOIN
      movies m ON m.id = c.movie_id
    WHERE
      a.name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
     COUNT(m.title) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      m.title, lead.name
    FROM
      castings lead_casting
    INNER JOIN
      movies m ON m.id = lead_casting.movie_id
    INNER JOIN
      actors lead ON lead.id = lead_casting.actor_id
    JOIN
      castings julie_casting ON m.id = julie_casting.movie_id
    JOIN
      actors julie ON julie.id = julie_casting.actor_id
    WHERE
      julie.name =  'Julie Andrews' and lead_casting.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      leads.name
    FROM
      actors leads
    INNER JOIN
      castings lead_casting ON lead_casting.actor_id = leads.id
    WHERE
      lead_casting.ord = 1
    GROUP BY
      leads.id
    HAVING
      COUNT(*) >= 15
    ORDER BY
      leads.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      movies.title, COUNT(*)
    FROM
      movies
    JOIN
      castings ON castings.movie_id = movies.id
    WHERE
      movies.yr = 1978
    GROUP BY
      movies.title
    ORDER BY
      COUNT(*) DESC, movies.title
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      actors.name
    FROM
      castings
    JOIN
      actors ON actors.id = castings.actor_id
    -- JOIN
    --   actors art_actors ON art_actors.id = castings.actor_id
    WHERE
      castings.movie_id IN (
        SELECT
          castings.movie_id
        FROM
          castings
        JOIN
          actors ON actors.id = castings.actor_id
        WHERE
          actors.name = 'Art Garfunkel'
      ) AND actors.name != 'Art Garfunkel'
  SQL
end
