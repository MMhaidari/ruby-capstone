require_relative './app/book_app'
require_relative './app/music_album_app'
require_relative './app/game_app'
require_relative './app/movie_app'
require_relative 'display_menu'

class Main
  def initialize
    @book_app = BookApp.new
    @music_album_app = MusicAlbumApp.new
    @game_app = GameApp.new
    @movie_app = MovieApp.new
  end

  def book_selection(option)
    case option
    when 1
      @book_app.list_all_books
    when 2
      @book_app.list_all_labels
    when 9
      @book_app.add_new_book
    end
  end

  def music_album_selection(option)
    case option
    when 3
      @music_album_app.list_all_music_albums
    when 4
      @music_album_app.list_all_genres
    when 10
      @music_album_app.add_new_music_album
    end
  end

  def game_selection(option)
    case option
    when 5
      @game_app.list_all_games
    when 6
      @game_app.list_all_authors
    when 11
      @game_app.add_new_game
    end
  end

  def movie_selection(option)
    case option
    when 7
      @movie_app.list_all_movies
    when 8
      @movie_app.list_all_sources
    when 12
      @movie_app.add_new_movie
    end
  end

  def options(option)
    book_selection(option)
    music_album_selection(option)
    game_selection(option)
    movie_selection(option)
  end
end

def main
  main = Main.new
  display_menu
  puts ''

  loop do
    option = gets.to_i
    if option == 13
      puts 'Exiting the Catalog of My Things app...'
      break
    elsif option > 13 || option < 1
      puts 'Invalid option!'
      display_menu
    else
      main.options(option)
      display_menu
    end
  end
end

main
