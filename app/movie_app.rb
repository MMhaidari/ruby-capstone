require_relative '../classes/movie'
require 'json'
require 'date'

class MovieApp
  attr_accessor :movies

  def initialize
    @movies = []
    load_movie
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
    save_movie
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

  def load_movie
    file = File.read('movie.json')
    json_data = JSON.parse(file, symbolize_names: true)
    json_data.each do |movie|
      @movies.push(Movies.new(movie[:name], movie[:publish_date], movie[:source], silent: movie[:silent]))
    end
  end
end
