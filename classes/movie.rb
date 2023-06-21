require_relative 'item'
require 'date'

class Movies < Item
  attr_reader :name, :source, :publish_date, :silent

  def initialize(name, publish_date, source, silent: true)
    super(Date.parse(publish_date))
    @name = name
    @publish_date = parse_publish_date(publish_date)
    @silent = silent
    @source = source
  end

  def can_be_archived?
    super() || @silent || (Time.now - @publish_date.to_time) > 10 * 365 * 24 * 60 * 60
  end

  def add_source(source)
    @source << source
  end

  def to_json(*_args)
    {
      name: @name,
      publish_date: @publish_date.iso8601,
      silent: @silent,
      source: @source
    }
  end

  def self.from_json(json_data)
    Movies.new(
      json_data['name'],
      json_data['publish_date'],
      json_data['source'],
      silent: json_data['silent']
    )
  end

  def parse_publish_date(publish_date)
    Date.parse(publish_date)
  rescue Date::Error
    raise ArgumentError, 'Invalid publish date format. Expected format: YYYY-MM-DD.'
  end
end
