require_relative 'item'
require 'date'

class Game < Item
  attr_reader :id
  attr_accessor :title, :multiplayer, :last_played_at, :publish_date

  def initialize(title, publish_date, last_played_at, author_id, multiplayer: nil)
    super(publish_date)
    @id = rand(1..100)
    @title = title
    @last_played_at = last_played_at
    @publish_date = publish_date
    @author_id = author_id
    @multiplayer = multiplayer
  end

  def can_be_archived?
    super && last_played_at < (Time.now - (2 * 365 * 24 * 60 * 60))

    false
  end
end
