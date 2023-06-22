require_relative '../classes/music_album'
require_relative '../classes/genre'
require 'json'
require 'date'

class MusicAlbumApp
  attr_accessor :music_albums

  def initialize
    @music_albums = []
    load_music_albums
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
    save_music_albums
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

  def load_music_albums
    file = File.read('music_album.json')
    json_data = JSON.parse(file, symbolize_names: true)
    json_data.each do |music_album|
      @music_albums.push(MusicAlbum.new(music_album[:name], music_album[:publish_date],
                                        on_spotify: music_album[:on_spotify], genre: music_album[:genre]))
    end
    puts 'Music albums loaded successfully!'
  end
end
