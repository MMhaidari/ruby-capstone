class Item
  attr_accessor :genre, :author, :source, :label, :publish_date
  attr_reader :id, :archived

  def initialize(publish_date, archived: false)
    @id = rand(1..1000)
    @publish_date = publish_date
    @archived = archived
    @label = nil
    @genre = nil
    @author = nil
  end

  def can_be_archived?
    # (Time.now - @publish_date) > 10 * 365 * 24 * 60 * 60
    # (Time.now - Time.parse(@publish_date.to_s)) > 10 * 365 * 24 * 60 * 60

    (Time.now - @publish_date.to_time) > 10 * 365 * 24 * 60 * 60
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def label=(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.add_author(self) unless author.items.include?(self)
  end
end
