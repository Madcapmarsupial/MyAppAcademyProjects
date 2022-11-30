def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where(actors: { name: those_actors})
     .group(:id)
     .having('COUNT(actors.id) >= ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
   Movie
    .select('AVG(score), (yr / 10) * 10 AS decade') 
    .group('decade')
    .order('AVG(score) DESC')
    .first
    .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  movies = Movie
      .joins(:actors)
      .where('actors.name = ?', name)
      .select('movies.id')

  Actor
    .joins(:movies)
    .where('actors.id = castings.actor_id AND castings.movie_id IN (?)', movies)
    .distinct
    .pluck('actors.name') - [name]
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_joins(:movies)
    .where('castings.ord IS NULL')
    .select('actors.name')
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"

  wrapped_str = "%#{whazzername.split('').join('%')}%" # 'a,b,c'
    
  Movie
    .joins(:actors)
    .where('UPPER(actors.name) LIKE UPPER(?)', wrapped_str)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

  Actor
    .joins(:movies)
    .select('MAX(movies.yr) - MIN(movies.yr) AS career, actors.id, actors.name')
    .group('actors.id')
    .order('career DESC')
    .limit(3)
end
