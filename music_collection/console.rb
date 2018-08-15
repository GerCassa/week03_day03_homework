require("pry-byebug")
require_relative("models/artist")
require_relative("models/album")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({
  "name" => "Cielo Razzo"
  })

artist1.save()

album1 = Album.new({
  "name" => "Miradas",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

album2 = Album.new({
  "name" => "Marea",
  "genre" => "Rock",
  "artist_id" => artist1.id
  })

album1.save()
album2.save()



binding.pry
nil
