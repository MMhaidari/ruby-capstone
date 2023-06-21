require_relative '../classes/book'
require 'rspec'

RSpec.describe Book do
  describe '#can_be_archived?' do
    it 'returns true if parent returns true' do
      book = Book.new('2001-01-01', 'No Starch Press', 'good', 'My Book')
      allow(book).to receive(:super).and_return(true)
      expect(book.can_be_archived?).to eq(true)
    end

    it 'returns false if parent returns false' do
      book = Book.new('2022-01-01', 'No Starch Press', 'good', 'My Book')
      allow(book).to receive(:super).and_return(false)
      expect(book.can_be_archived?).to eq(false)
    end

    it 'returns true if cover state is bad' do
      book = Book.new('2001-01-01', 'No Starch Press', 'bad', 'My Book')
      expect(book.can_be_archived?).to eq(true)
    end
  end
end
