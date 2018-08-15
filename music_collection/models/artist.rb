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

  def Artist.all()
    sql = "SELECT * FROM artists"
    artists_hash = SqlRunner.run(sql)
    artists = artists_hash.map {|artist| Artist.new(artist)}
    return artists
  end



end
