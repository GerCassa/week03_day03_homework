require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_reader :id
  attr_accessor :name

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
  end

  def save()
    sql = "INSERT INTO artists
      (name)
      VALUES
      ($1) RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    by_art = SqlRunner.run(sql, values)
    return by_art.map {|album| Album.new(album)}
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

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def Artist.find_artist_by_id(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artists = SqlRunner.run(sql, values)
    return artists.map {|artist| Artist.new(artist)}[0]
  end

  def Artist.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { |artist| Artist.new(artist) }
  end

  def Artist.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end


end
