require_relative 'item'
require 'date'

class Movies < Item
    attr_reader :name, :source, :publish_date, :silent
    def initialize(name, publish_date, source, archived: false, silent: true)
        super(publish_date)
        @name = name
        @publish_date = parse_publish_date(publish_date)
        @silent = silent
        @source = source      
    end

    def can_be_archived?
        super() || @silent
    end

    def add_source(source)
        @source << source     
    end

    def parse_publish_date(publish_date)
        Date.parse(publish_date)
    rescue Date::Error
        raise ArgumentError,  'Invalid publish date format. Expected format: YYYY-MM-DD.'
    end
end