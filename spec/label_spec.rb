require_relative '../classes/label'
require 'rspec'

RSpec.describe Label do
  describe '#item_add' do
    it 'adds the item to the label' do
      label = Label.new('My Label', 'red')
      item = double('Item')
      expect(item).to receive(:label=).with(label)
      label.item_add(item)
      expect(label.items).to include(item)
    end
  end
end
