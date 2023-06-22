require_relative './classes/music_album'
require_relative './classes/genre'
require_relative 'classes/movie'
require_relative './classes/game'
require_relative './classes/author'
require_relative './modules/save_data'
require_relative './modules/load_data'
require_relative './classes/book'
require_relative './classes/label'
require 'json'
require 'date'

class App
  include SaveData
  include LoadData
  attr_accessor :books, :music_albums, :games, :movies

  def initialize    
    @books = []
    @labels = []
    @music_albums = []
    @games = []
    @movies = []
    load_data
  end

 def add_new_book
  display_message('Enter the title of the book: ')
  title = gets.chomp
  display_message('Enter the color of the book cover: ')
  color = gets.chomp
  display_message('Enter the publish date of the book (YYYY-MM-DD): ')
  publish_date = gets.chomp
  display_message('Enter the publisher of the book: ')
  publisher = gets.chomp
  cover_state = input_cover_state

  book = Book.new(title, publisher, publish_date, cover_state)
  label = Label.new(title, color)
  label.add_item(book)
  @books.push(book)
  @labels.push(label)
  display_message('Book added successfully.')
  save_books
  save_label
end

  def input_cover_state
    loop do
      display_message('Enter the cover state of the book (GOOD or BAD): ')
      cover_state = gets.chomp.upcase
      return cover_state if %w[GOOD BAD].include?(cover_state)

      display_message('Invalid cover state. Please enter either GOOD or BAD.')
    end
  end
  
  def list_all_books
    puts 'Books:'
    @books.each_with_index do |book, index|
      book_name = "#{index + 1}. Book Name: #{book.title}"
      publish_date = " - Publish Date: #{book.publish_date}"
      publisher = " - Publisher: #{book.publisher}"
      cover_state = " - Cover State: #{book.cover_state}"
      book_info = book_name + publish_date + publisher + cover_state
      puts book_info
    end
  end

  def list_all_labels
    puts 'Labels:'
    @labels.each_with_index do |label, index|
      label_name = "#{index + 1}. Label Name: #{label.title}"
      color = " - Color: #{label.color}"
      label_info = label_name + color
      puts label_info
    end
  end

  private

  def display_message(message)
    puts '-------------------------------------------'
    puts message.chomp
    puts '-------------------------------------------'
  end

  def list_all_music_albums
    puts 'Music albums:'
    @music_albums.each_with_index do |music_album, index|
      album_name = "#{index + 1}. Album Name: #{music_album.name}"
      publish_date = " - publish date: #{music_album.publish_date}"
      on_spotify = " - On Spotify: #{music_album.on_spotify}"
      genre = " - Genre: #{music_album.genre}"
      album_info = album_name + publish_date + on_spotify + genre
      puts album_info
    end
  end

  def list_all_genres
    genres = @music_albums.map(&:genre)
    genres.uniq.each_with_index do |genre, index|
      puts "#{index + 1}. #{genre}"
    end
  end

  def list_all_games
    puts 'Games:'
    @games.each_with_index do |game, index|
      name = "#{index + 1}. Name: #{game.name}"
      last_played_at = " - Last Played At: #{game.last_played_at}"
      multiplayer = game.multiplayer.nil? ? '' : " - Multiplayer: #{game.multiplayer}"
      publish_date = " - Publish Date: #{game.publish_date}"
      author = "- Author: #{game.author}"
      game_info = name + last_played_at + publish_date + multiplayer + author
      puts game_info
    end
  end

  def list_all_authors
    puts 'Authors:'
    authors = @games.map(&:author)
    authors.uniq.each_with_index do |author, index|
      puts "#{index + 1}. #{author}"
    end
  end

  def list_all_movies
    puts '**************----------------*************'
    puts '              Available movies'
    puts '*************-----------------*************'
    puts "\n"
    @movies.each_with_index do |movie, index|
      name = "#{index + 1}. Movie Name:::::... #{movie.name}\n"
      publish = "   Publish Date:::... #{movie.publish_date}\n"
      silent = "   Silent status::... #{movie.silent}\n"
      source = "   Sources::::::::... #{movie.source}\n"
      movie_details = name + publish + silent + source
      puts "#{movie_details}\n"
      puts '                   ***'
    end
    puts '                 ***END***'
  end

  def list_all_sources
    puts '**************----------------*************'
    puts '              Movie sources'
    puts '*************-----------------*************'
    puts "\n"
    sources = @movies.map(&:source)
    sources.uniq.each_with_index do |source, index|
      puts "#{index + 1}. #{source}\n"
    end
    puts '                 ***END***'
  end
  
  def add_new_music_album
    puts 'Enter music album details:'
    puts 'Enter album title:'
    name = gets.chomp
    puts 'Enter date of release (YYYY-MM-DD):'
    publish_date = gets.chomp
    puts 'Is it on Spotify? (Y/N):'
    on_spotify = gets.chomp.downcase == 'y'
    puts 'Enter the genre of the music album:'
    genre = gets.chomp.downcase
    album = MusicAlbum.new(name, publish_date, on_spotify: on_spotify, genre: genre)
    @music_albums.push(album)
    puts "Album '#{album.name}' has been added."
    save_data
  end

  def add_new_game
    puts 'Enter Game details below'
    puts 'Enter name:'
    name = gets.chomp
    puts 'Enter Publish date (YYYY-MM-DD):'
    publish_date = gets.chomp
    puts 'Enter Last played date (YYYY-MM-DD):'
    last_played_at = gets.chomp
    puts 'Enter author\'s first name:'
    first_name = gets.chomp
    puts 'Enter author\'s last name:'
    last_name = gets.chomp
    puts 'Enter the multiplayer count:'
    multiplayer = gets.chomp.to_i

    author_name = "#{first_name} #{last_name}"
    game = Game.new(name, publish_date, last_played_at, multiplayer, author: author_name)
    @games.push(game)
    puts "Game '#{game.name}' added successfully"
    save_data
  end

  def add_new_movie
    puts 'Enter Movie details below'
    puts 'Enter name: '
    name = gets.chomp
    puts 'Enter Publish date YYYY-MM-DD'
    publish_date = gets.chomp
    puts 'Is the movie silent or not Y/N'
    input = gets.chomp.downcase
    silent = case input
             when 'y' then true
             when 'n' then false
             else
               puts 'Invalid input. Assuming the movie is not silent.'
               false
             end
    puts 'Enter the source of the movie'
    source = gets.chomp.downcase
    movie = Movies.new(name, publish_date, source, silent: silent)
    @movies.push(movie)
    puts "Movie '#{movie.name}' added successfully"
    save_data
  end

  def quit
    puts 'Good bye'
    exit
  end
end
