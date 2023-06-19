class Item
    attr_accessor :genre, :author, :source, :label, :pulish_date
    attr_reader :id, :archived

    def initialize(pulish_date, archived: false)
        @id = rand(1..1000)
        @pulish_date = pulish_date
        @archived = archived
        @labe = nil
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