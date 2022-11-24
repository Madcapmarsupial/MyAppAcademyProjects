class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here 
    #select id from artist
    #count count tracks on album filteralbums through artist.id
    Album.joins(:tracks).select('albums.*, COUNT(*) AS track_count').where(['albums.artist_id = ?', self.id]).group('albums.id')
  end
end

