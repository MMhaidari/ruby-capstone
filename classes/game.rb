require_relative './item'
require 'date'

class Game < Item
  attr_accessor :name, :multiplayer, :last_played_at, :publish_date

  def initialize(name, publish_date, last_played_at, multiplayer, author: [])
    super(parse(publish_date))
    @name = name
    @last_played_at = parse(last_played_at)
    @publish_date = parse(publish_date)
    @multiplayer = multiplayer
    @author = author
  end

  def can_be_archived?
    super && last_played_at < (Time.now - (2 * 365 * 24 * 60 * 60))
  end

  def add_author(author)
    @author << author
  end

  def to_json(*_args)
    {
      name: @name,
      publish_date: @publish_date.iso8601,
      last_played_at: @last_played_at.iso8601,
      multiplayer: @multiplayer,
      author: @author
    }
  end

  def self.from_json(json_data)
    Game.new(
      json_data['name'],
      json_data['publish_date'],
      json_data['last_played_at'],
      multiplayer: json_data['multiplayer'],
      author: json_data['author']
    )
  end

  private

  def parse(value)
    return value if value.is_a?(Time)

    DateTime.parse(value).to_time
  rescue ArgumentError
    raise ArgumentError, 'Invalid date format. Expected format: YYYY-MM-DD.'
  end
end
