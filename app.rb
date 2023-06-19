class App
  def initialize
    @books = []
    @music_albums = []
    @games = []
    @movies = []
  end

  def add_item
    puts 'Select item type:'
    puts '1. Book'
    puts '2. Music Album'
    puts '3. Game'
    puts '2. Movie'
    print 'Choice: '
    type = gets.chomp.to_i

    case type
    when 1
      add_book
    when 2
      add_music_album
    when 3
      add_game
    when 4
      add_movie
    else
      puts 'Invalid option!'
    end
  end

  def add_book
    puts 'Enter book details:'
  end

  def add_music_album
    puts 'Enter music album details:'
  end

  def add_game
    puts 'Enter game details:'
  end

  def add_movie
    puts 'Enter movie details:'
  end
end
