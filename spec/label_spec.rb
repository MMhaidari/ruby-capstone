require_relative '../classes/label'
require_relative '../classes/item'
require_relative '../classes/list_all_book_and_label'
require 'rspec'

RSpec.describe Label do
  describe '#add_item' do
    it 'adds the item to the label' do
      label = Label.new('My Label', 'red')
      item = Item.new('2001-01-01')
      label.add_item(item)
      expect(label.items).to include(item)
    end
  end
end
