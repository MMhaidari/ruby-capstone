require_relative '../classes/source'
require 'rspec'

describe Source do
  let(:source_name) { 'on-line' }
  let(:source) { Source.new(source_name) }

  it 'Adds the "item" to the source' do
    item = double('item', source: nil)
    allow(item).to receive(:source=)
    source.add_item(item)
    expect(source.items).to include(item)
  end

  it "Should 'add self' as a property of the item object" do
    item = double('item')
    allow(item).to receive(:source=)
    allow(item).to receive(:source).and_return(source)
    expect(item.source).to eq(source)
  end
  it "Should ensure that their is an argument name'" do
    expect(source).to have_attributes(name: 'on-line')
  end
  it "Should ensure that the id is an integer'" do
    expect(source.instance_variable_get(:@id)).to be_an(Integer)
  end

  it 'Should have an empty array' do
    expect(source.items).to be_an(Array)
    expect(source.items).to be_empty
  end
end
