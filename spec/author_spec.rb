require_relative '../classes/author'
require_relative '../classes/game'

RSpec.describe Author do
  describe '#initialize' do
    it 'sets the attributes correctly' do
      first_name = 'Mudassir'
      last_name = 'Nazir'

      author = Author.new(first_name, last_name)

      expect(author.first_name).to eq(first_name)
      expect(author.last_name).to eq(last_name)
      expect(author.items).to be_empty
    end
  end
end
