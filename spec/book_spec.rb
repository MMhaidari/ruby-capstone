require_relative '../classes/book'
require 'date'
require 'rspec'

RSpec.describe Book do
  let(:publish_date) { Time.now - (11 * 365 * 24 * 60 * 60) }
  let(:publisher) { 'ABC Publishing' }
  let(:cover_state) { 'good' }
  let(:title) { 'The Great Book' }
  let(:book) { Book.new(title, publish_date, publisher, cover_state) }

  describe '#initialize' do
    it 'sets the attributes correctly' do
      expect(book.publish_date).to eq(publish_date)
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
      expect(book.title).to eq(title)
    end
  end

  describe '#can_be_archived?' do
    context 'with old publish date' do
      it 'returns true' do
        expect(book.can_be_archived?).to be true
      end
    end

    context 'with bad cover state' do
      let(:book) { Book.new(title, publish_date, publisher, 'bad') }

      it 'returns true' do
        expect(book.can_be_archived?).to be true
      end
    end

    context 'with recent publish date and good cover state' do
      let(:book) { Book.new(title, Time.now - (9 * 365 * 24 * 60 * 60), publisher, 'good') } # 9 years ago

      it 'returns false' do
        expect(book.can_be_archived?).to be false
      end
    end
  end

  describe '#move_to_archive' do
    context 'when book can be archived' do
      before { allow(book).to receive(:can_be_archived?).and_return(true) }

      it 'sets archived to true' do
        book.move_to_archive
        expect(book.archived).to be true
      end
    end

    context 'when book cannot be archived' do
      before { allow(book).to receive(:can_be_archived?).and_return(false) }

      it 'does not set archived to true' do
        book.move_to_archive
        expect(book.archived).to be false
      end
    end
  end
end
