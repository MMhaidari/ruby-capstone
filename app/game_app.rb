require_relative '../classes/game'
require_relative '../classes/author'
require 'json'
require 'date'

class GameApp
  attr_accessor :games, :authors

  def initialize
    @games = []
    @authors = []
    load_games
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
    save_games
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

  def load_games
    if File.exist?('games.json')
      file = File.read('games.json')
      json_data = JSON.parse(file, symbolize_names: true)
      json_data.each do |game|
        @games.push(Game.new(game[:name], game[:publish_date], game[:last_played_at],
                             game[:multiplayer], author: game[:author]))
      end
      puts 'Games loaded successfully!'
    else
      puts 'No games data found.'
    end
  end
end
