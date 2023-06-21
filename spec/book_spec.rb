require 'rspec'
require_relative '../classes/book'

RSpec.describe Book do
  describe '#can_be_archived?' do
    it 'returns true if parent returns true' do
      book = Book.new('No Starch Press', 'good', '2001-01-01')
      test_method = book.can_be_archived?
      expect(test_method).to eq(true)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if parent returns true' do
      book = Book.new('No Starch Press', 'good', '2022-01-01')
      test_method = book.can_be_archived?
      expect(test_method).to eq(false)
    end
  end
end
