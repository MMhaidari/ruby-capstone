require 'json'

module SaveData
  def save_data
    save_music_albums
  end

  def save_music_albums
    json_data = @music_albums.map do |music_album|
      {
        name: music_album.name,
        publish_date: music_album.publish_date.iso8601,
        on_spotify: music_album.on_spotify,
        genre: music_album.genre
      }
    end
    File.write('music_album.json', JSON.pretty_generate(json_data))
    puts 'Music albums saved successfully!'
  end
end
