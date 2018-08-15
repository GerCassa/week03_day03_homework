require('pg')
require_relative('../db/sql_runner')

class Album

  attr_reader :id
  attr_accessor :name, :genre, :artist_id

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @genre = info['genre']
    @artist_id = info['artist_id'].to_i if info['artist_id']
  end

  def save()
    sql = "INSERT INTO albums
      (name, genre, artist_id)
      VALUES
      ($1, $2, $3) RETURNING *"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def by_artist()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@artist_id]
    by_art = SqlRunner.run(sql, values)
    return by_art.map {|album| Album.new(album)}
  end


  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end


end
