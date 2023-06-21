require 'json'

module SaveData
  def save_data
    save_music_albums
    save_movie
    save_games
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

  def save_movie
    json_data = @movies.map do |movie|
      {
        name: movie.name,
        publish_date: movie.publish_date,
        silent: movie.silent,
        source: movie.source
      }
    end
    File.write('movie.json', JSON.pretty_generate(json_data))
    puts 'Movie saved successfully'
  end

  def save_games
    json_data = @games.map do |game|
      {
        name: game.name,
        publish_date: game.publish_date.to_datetime.iso8601,
        last_played_at: game.last_played_at.to_datetime.iso8601,
        multiplayer: game.multiplayer,
        author: game.author
      }
    end
    File.write('games.json', JSON.pretty_generate(json_data))
    puts 'Games saved successfully!'
  end
end
