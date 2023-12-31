require_relative 'item'

class Book < Item
  attr_reader :publisher, :cover_state, :title

  def initialize(title, publish_date, publisher, cover_state)
    super(publish_date)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || cover_state == 'bad'
  end
end
