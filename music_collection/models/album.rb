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




end
