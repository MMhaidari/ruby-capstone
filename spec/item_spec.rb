require 'rspec'
require 'date' # Add this line to require the 'date' module
require_relative '../classes/item'

RSpec.describe Item do
  it 'returns true if the publish date is more than 10 years ago' do
    publish_date = DateTime.now - ((10 * 365) + 1)
    item = Item.new(publish_date)
    expect(item.can_be_archived?).to eq(true)
  end

  it 'returns false if the publish date is less than 10 years ago' do
    publish_date = DateTime.now
    item = Item.new(publish_date)
    expect(item.can_be_archived?).to eq(false)
  end

  it 'sets the archived flag to true if the item can be archived' do
    publish_date = DateTime.now - ((10 * 365) + 1)
    item = Item.new(publish_date)
    item.move_to_archive
    expect(item.archived).to eq(true)
  end

  it 'leaves the archived flag as false if the item cannot be archived' do
    publish_date = DateTime.now
    item = Item.new(publish_date)
    item.move_to_archive
    expect(item.archived).to eq(false)
  end
end
