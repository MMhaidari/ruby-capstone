require 'json'

module LoadData
  def load_data
    load_music_albums
    load_movie
  end

  def load_music_albums
    file = File.read('music_album.json')
    json_data = JSON.parse(file, symbolize_names: true)
    json_data.each do |music_album|
      @music_albums.push(MusicAlbum.new(music_album[:name], music_album[:publish_date],
                                        on_spotify: music_album[:on_spotify], genre: music_album[:genre]))
    end
    puts 'Music albums loaded successfully!'
  end

  def load_movie
    file = File.read('movie.json')
    json_data = JSON.parse(file, symbolize_names:true)
    json_data.each do |movie|
      @movies.push(Movies.new(movie[:name], movie[:publish_date], movie[:source], silent: movie[:silent]))
    end
  end
end
