class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :id, :archived

  def initialize(publish_date, archived: false)
    @id = rand(1..1000)
    @publish_date = pulish_date
    @archived = archived
    @label = nil
    @genre = nil
    @author = author
  end

  def can_be_archived?
    (Time.now.year - @publish_date.year) > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
