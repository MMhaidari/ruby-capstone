require_relative './item'
require 'date'

class MusicAlbum < Item
  attr_accessor :name, :genre, :publish_date, :on_spotify

  def initialize(name, publish_date, on_spotify: false, genre: [])
    super(publish_date)
    @name = name
    @publish_date = parse_publish_date(publish_date)
    @on_spotify = on_spotify
    @genre = genre
  end

  def can_be_archived?
    super() && (Date.today.year - @publish_date.year) > 10 && @on_spotify
  end

  def add_genre(genre)
    @genre << genre
  end

  def to_json(*_args)
    {
      name: @name,
      publish_date: @publish_date.iso8601,
      on_spotify: @on_spotify,
      genre: @genre
    }
  end

  def self.from_json(json_data)
    MusicAlbum.new(
      json_data['name'],
      json_data['publish_date'],
      on_spotify: json_data['on_spotify'],
      genre: json_data['genre']
    )
  end

  private

  def parse_publish_date(publish_date)
    Date.parse(publish_date)
  rescue Date::Error
    raise ArgumentError, 'Invalid publish date format. Expected format: YYYY-MM-DD.'
  end
end
