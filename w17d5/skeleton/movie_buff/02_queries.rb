def eighties_b_movies
  # List all the movies from 1980-1989 with scores falling between
  # 3 and 5 (inclusive).
  # Show the id, title, year, and score.
  scores = (30..50).to_a.map {|num| (num * 0.1).floor(2)}
  Movie
    .where('score IN (?) AND yr IN (?)', scores, (1980..1989).to_a)
    .select(:id, :title, :score, :yr)
end

def bad_years
  # List the years in which a movie with a rating above 8 was not released.
  Movie
    .group(:yr)
    .having('MAX(score) < 8')
    .pluck(:yr)
end

def cast_list(title)
  # List all the actors for a particular movie, given the title.
  # Sort the results by starring order (ord). Show the actor id and name.

  Actor
    .joins(:movies)
    .where('movies.title = ?', title)
    .order('castings.ord ASC')
    .select('actors.id, actors.name')
end

def vanity_projects
  # List the title of all movies in which the director also appeared
  # as the starring actor.
  # Show the movie id and title and director's name.

  # Note: Directors appear in the 'actors' table.

  Movie
    .joins(:actors)
    .where('castings.actor_id = movies.director_id AND castings.ord = 1')
    .select('movies.title, movies.id, actors.name')
end

def most_supportive
  # Find the two actors with the largest number of non-starring roles.
  # Show each actor's id, name and number of supporting roles.
  Actor
    .joins(:movies)
    .where('castings.ord > 1')
    .group('actors.id')
    .order('COUNT(actors.id) DESC')
    .select( 'actors.id, actors.name, COUNT(actors.id) AS roles')
    .limit(2)
end
