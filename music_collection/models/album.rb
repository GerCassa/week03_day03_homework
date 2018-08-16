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

  def update()
    sql = "UPDATE albums
    SET
    (name, genre, artist_id)
    =
    ($1, $2, $3)
    WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artists = SqlRunner.run(sql, values)
    return Artist.new(artists[0])
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Album.find_album_by_id(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    albums = SqlRunner.run(sql, values)
    return albums.map {|album| Album.new(album)}[0]
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql)
    return albums.map { |album| Album.new(album) }
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end


end
