require 'json'
require 'date'
require_relative '../classes/book'
require_relative '../classes/label'

class BookApp
  attr_accessor :books, :labels

  def initialize
    @books = []
    @labels = []
    load_books
    load_label
  end

  def add_new_book
    display_message('Enter the title of the book: ')
    title = gets.chomp
    display_message('Enter the color of the book cover: ')
    color = gets.chomp
    display_message('Enter the publish date of the book (YYYY-MM-DD): ')
    publish_date = gets.chomp
    display_message('Enter the publisher of the book: ')
    publisher = gets.chomp
    cover_state = input_cover_state

    book = Book.new(title, publish_date, publisher, cover_state)
    label = Label.new(title, color)
    label.add_item(book)
    @books.push(book)
    @labels.push(label)
    display_message('Book added successfully.')
    save_books
    save_label
  end

  def input_cover_state
    loop do
      display_message('Enter the cover state of the book (GOOD or BAD): ')
      cover_state = gets.chomp.upcase
      return cover_state if %w[GOOD BAD].include?(cover_state)

      display_message('Invalid cover state. Please enter either GOOD or BAD.')
    end
  end

  def list_all_books
    puts 'Books:'
    @books.each_with_index do |book, index|
      book_name = "#{index + 1}. Book Name: #{book.title}"
      publish_date = " - Publish Date: #{book.publish_date}"
      publisher = " - Publisher: #{book.publisher}"
      cover_state = " - Cover State: #{book.cover_state}"
      book_info = book_name + publish_date + publisher + cover_state
      puts book_info
    end
  end

  def list_all_labels
    puts 'Labels:'
    @labels.each_with_index do |label, index|
      label_name = "#{index + 1}. Label Name: #{label.title}"
      color = " - Color: #{label.color}"
      label_info = label_name + color
      puts label_info
    end
  end

  def save_books
    json_data = @books.map do |book|
      {
        title: book.title,
        publisher: book.publisher,
        publish_date: book.publish_date,
        cover_state: book.cover_state
      }
    end
    File.write('book.json', JSON.pretty_generate(json_data))
    puts 'Book saved successfully'
  end

  def save_label
    json_data = @labels.map do |label|
      {
        title: label.title,
        color: label.color
      }
    end
    File.write('label.json', JSON.pretty_generate(json_data))
    puts 'Label saved successfully'
  end

  def load_books
    file = File.read('book.json')
    json_data = JSON.parse(file, symbolize_names: true)
    json_data.each do |book|
      @books.push(Book.new(book[:title], book[:publish_date], book[:publisher], book[:cover_state]))
    end
  end

  def load_label
    file = File.read('label.json')
    json_data = JSON.parse(file, symbolize_names: true)
    json_data.each do |label|
      @labels.push(Label.new(label[:title], label[:color]))
    end
  end

  private

  def display_message(message)
    puts '-------------------------------------------'
    puts message.chomp
    puts '-------------------------------------------'
  end
end
