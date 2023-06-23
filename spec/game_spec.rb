require_relative '../classes/game'
require_relative '../classes/item'
require 'date'

RSpec.describe Game do
  let(:publish_date) { DateTime.parse('2021-01-01').to_time }
  let(:last_played_at) { DateTime.parse('2022-06-01').to_time }
  let(:multiplayer) { 2 }
  let(:author) { %w[Mudassir NAzir] }

  subject { described_class.new('Game', publish_date, last_played_at, multiplayer, author: author) }

  describe '#initialize' do
    it 'sets the name' do
      expect(subject.name).to eq('Game')
    end

    it 'sets the publish_date' do
      expect(subject.publish_date).to eq(publish_date)
    end

    it 'sets the last_played_at attribute' do
      expect(subject.last_played_at).to eq(last_played_at)
    end

    it 'sets the multiplayer attribute' do
      expect(subject.multiplayer).to eq(multiplayer)
    end

    it 'sets the author' do
      expect(subject.author).to eq(author)
    end
  end

  describe '#add_author' do
    it 'adds a new author to the author list' do
      subject.add_author('Bob Smith')
      expect(subject.author).to include('Bob Smith')
    end
  end
end
