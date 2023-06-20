class Source
    attr_accessor :name, :items
  
    def initialize(name)
      @id = rand(1..1000)
      @name = name
      @items = []
    end
  
    def add_item(item)
      item.source = self
      @items << item
    end
  end
