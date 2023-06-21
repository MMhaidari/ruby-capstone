require_relative '../classes/movie'
require_relative '../classes/item'
require 'date'
require 'rspec'
require 'json'

describe Movies do
  let(:name) { 'Greatest' }
  let(:publish_date) { '2020-12-12' }
  let(:source) { [] }
  let(:silent) { true }
  let(:movie) { Movies.new(name, publish_date, source) }

  it "Should have the 'following attributes'" do
    expect(movie).to have_attributes(name: 'Greatest')
    expect(movie).to have_attributes(publish_date: movie.parse_publish_date('2020-12-12'))
    expect(movie).to have_attributes(silent: true)
    expect(movie).to have_attributes(source: [])
  end

  it 'Should add the source to the source array' do
    source = double(source)
    movie.add_source(source)
    expect(movie.source).to include(source)
  end

  it 'Should determone if it can be archived' do
    expect(movie.can_be_archived?).to be_truthy
  end

  it 'Should serialize to JSON' do
    expected_json =
      {
        name: 'Greatest',
        publish_date: '2020-12-12',
        source: [],
        silent: true
      }
    expect(movie.to_json).to eq(expected_json)
  end

  it 'Should deserialize from JSON' do
    json_data = {
      'name' => 'Greatest',
      'publish_date' => '2020-12-12',
      'silent' => true,
      'source' => []
    }.to_json

    deserialized_movie = Movies.from_json(JSON.parse(json_data))
    expect(deserialized_movie.name).to eql('Greatest')
    expect(deserialized_movie.publish_date).to eql(Date.parse('2020-12-12'))
    expect(deserialized_movie.silent).to be_truthy
    expect(deserialized_movie.source).to eql([])
  end  
end
