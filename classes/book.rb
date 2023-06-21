require_relative 'item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(author, publish_date, publisher, cover_state, label = nil)
    super(nil, author, publish_date, label)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    result = super
    result || cover_state == 'bad'
  end
end