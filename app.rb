require_relative './classes/music_album'
require_relative 'classes/movie'
require_relative './modules/save_data'
require_relative './modules/load_data'

class App
  include SaveData
  include LoadData
  attr_accessor :books, :music_albums, :games, :movies

  def initialize
    @books = []
    @music_albums = []
    @games = []
    @movies = []
    load_data
  end

  def list_all_books
    puts 'Enter book details:'
  end

  def list_all_labels; end

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

  def list_all_games; end

  def list_all_authors; end

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

  def add_new_book; end

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

  def add_new_game; end

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
