require 'rspec'
require_relative '../classes/item.rb'

RSpec.describe Item do
    describe '#can_be_archived?' do
      it 'returns true if the publish date is more than 10 years ago' do
        publish_date = Time.now - (10 * 365 * 24 * 60 * 60 + 1) # Set publish date more than 10 years ago
        item = Item.new(publish_date)
        expect(item.can_be_archived?).to eq(true)
      end
  
      it 'returns false if the publish date is less than 10 years ago' do
        publish_date = Time.now
        item = Item.new(publish_date)
        expect(item.can_be_archived?).to eq(false)
      end
    end
  
    describe '#move_to_archive' do
      it 'sets the archived flag to true if the item can be archived' do
        publish_date = Time.now - (10 * 365 * 24 * 60 * 60 + 1) # Set publish date more than 10 years ago
        item = Item.new(publish_date)
        item.move_to_archive
        expect(item.archived).to eq(true)
      end
  
      it 'leaves the archived flag as false if the item cannot be archived' do
        publish_date = Time.now
        item = Item.new(publish_date)
        item.move_to_archive
        expect(item.archived).to eq(false)
      end
    end
  end