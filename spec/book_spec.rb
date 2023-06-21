require_relative '../classes/book'
require 'date'
require 'rspec'
require_relative '../classes/list_all_book_and_label'

RSpec.describe Book do
  describe '#can_be_archived?' do
    it 'returns true if parent returns true' do
      book = Book.new('2001-01-01', 'No Starch Press', 'good', 'My Book')
      allow(book).to receive(:super).and_return(true)
      test_method = book.can_be_archived?
      expect(test_method).to eq(true)
    end

    it 'returns false if parent returns false' do
      book = Book.new('2022-01-01', 'No Starch Press', 'good', 'My Book')
      allow(book).to receive(:super).and_return(false)
      test_method = book.can_be_archived?
      expect(test_method).to eq(false)
    end

    it 'returns true if cover state is bad' do
      book = Book.new('2001-01-01', 'No Starch Press', 'bad', 'My Book')
      test_method = book.can_be_archived?
      expect(test_method).to eq(true)
    end
  end
end
