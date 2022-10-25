# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


tag_topics = TagTopic.create([{topic: 'News', short_url_id: 3}, {topic: 'Sports', short_url_id: 3}])
tag_topics_two = TagTopic.create([{topic: 'News', short_url_id: 2}, {topic: 'Music', short_url_id: 3}])
tag_topics_three = TagTopic.create([{topic: 'Politics', short_url_id: 1}, {topic: 'News', short_url_id: 4}])


visit_group = Visit.create([{visitor_id: 1, url_id: 1}, {visitor_id: 2, url_id: 1}, {visitor_id: 3, url_id: 1}])