# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)





tag_topics_group = TagTopic.create([
  {topic: 'Politics', short_url_id: ShortenedUrl.last.id},
  {topic: 'News', short_url_id: ShortenedUrl.first.id}
])

#ShortenedUrl.create_short_url!(User.all[4], 'www.boxes.com')
visit_group = Visit.create([
  {visitor_id: 1, url_id: 1},
  {visitor_id: 2, url_id: 1},
  {visitor_id: 3, url_id: 1}
])

user_group = ShortenedUrl.create([
  {user_id: 1, short_url: 'one', long_url: 'one_url'},
  {user_id: 2, short_url: 'two', long_url: 'two_url'}, 
  {user_id: 3, short_url: 'three', long_url: 'three_url'}
])

vote_group = Vote.create([
  {user_id: 4, url_id: ShortenedUrl.last.id},
  {user_id: 1, url_id: ShortenedUrl.first.id},
  {user_id: 4, url_id: ShortenedUrl.first.id},
  {user_id: 2, url_id: ShortenedUrl.first.id},
  {user_id: 3, url_id: ShortenedUrl.first.id},
  {user_id: 3, url_id: ShortenedUrl.first.id}
])
#Visit.create([{visitor_id: 4, url_id: su1.id}, {visitor_id: 5, url_id: su2.id}])