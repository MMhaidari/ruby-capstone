require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(id, genre, author, source, label, publish_date, multiplayer, last_played_at)
    super(id, genre, author, source, label, publish_date)
    @multiplayer = multiplayer
    @last_played_at = last_played_at
  end

  def can_be_archived?
    super && last_played_at < (Time.now - (2 * 365 * 24 * 60 * 60))

    false
  end
end
