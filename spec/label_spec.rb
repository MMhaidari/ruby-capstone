require_relative '../classes/label'
require 'rspec'

RSpec.describe Label do
  describe '#initialize' do
    it 'creates a label with the given title and color' do
      label = Label.new('My Label', 'red')
      expect(label.title).to eq('My Label')
      expect(label.color).to eq('red')
    end
  end

  describe '#add_item' do
    it 'adds the item to the label' do
      label = Label.new('My Label', 'red')
      item = Item.new('2022-01-01')
      label.add_item(item)
      expect(label.items).to include(item)
    end
  end
end
