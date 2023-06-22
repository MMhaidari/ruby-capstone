require 'json'

module SaveData
  def save_data
    save_music_albums
    save_movie
    store_book
    store_label
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

  def store_book(book)
    hash = {
      id: book.id,
      title: book.title,
      publisher: book.publisher,
      publish_date: book.publish_date,
      cover_state: book.cover_state
    }

    stored_book = load_json('data/books.json')
    stored_book << hash
    write_json('data/books.json', stored_book)
  end

  def store_label(label)
    hash = {
      id: label.id,
      title: label.title,
      color: label.color
    }

    stored_label = load_json('data/labels.json')
    stored_label << hash
    write_json('data/labels.json', stored_label)
  end

  def load_json(file_path)
    File.empty?(file_path) ? [] : JSON.parse(File.read(file_path))
  rescue Errno::ENOENT
    []
  end

  def write_json(file_path, data)
    FileUtils.mkdir_p('data')
    File.write(file_path, data.to_json)
  end
  
end
