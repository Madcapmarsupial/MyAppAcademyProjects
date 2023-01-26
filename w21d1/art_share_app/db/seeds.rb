# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create(username: 'bob')
User.create(username: 'jon')

Artwork.create(title: 'spiece', artist_id: User.first.id, image_url: 'bleh')
Artwork.create(title: 'spiece2', artist_id: User.first.id, image_url: 'blej')
ArtworkShare.create(viewer_id: User.last.id, artwork_id: Artwork.first.id)



