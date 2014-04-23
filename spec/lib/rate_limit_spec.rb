require 'spec_helper'

describe 'successful Github rate_limit GET request' do
  before do
    @response = RestClient.get 'https://api.github.com/rate_limit'
    @rate_limit_hash = JSON.parse(@response.body)
    @core = @rate_limit_hash['resources']['core']
    @search = @rate_limit_hash['resources']['search']
    @rate = @rate_limit_hash['rate']
  end
  
  it "returns an unempty hash" do
    expect(@rate_limit_hash['resources']).not_to be_empty
  end
  
  it "returns a response code" do
    expect(@response.code).to eq(200)
  end
  
  it 'returns a core limit count' do
    expect(@core['limit']).to be_a(Fixnum)
  end
  
  it 'returns a core remaining count' do
    expect(@core['remaining']).to be_a(Fixnum)
  end
  
  it 'returns a core reset time' do
    expect(@core['reset']).to be_a(Fixnum)
  end
  
  it 'returns a search limit count' do
    expect(@search['limit']).to be_a(Fixnum)
  end

  it 'returns a search remaining count' do
    expect(@search['remaining']).to be_a(Fixnum)
  end
  
  it 'returns a search reset time' do
    expect(@search['reset']).to be_a(Fixnum)
  end
  
  it 'returns a rate limit count' do
    expect(@rate['limit']).to be_a(Fixnum)
  end
  
  it 'returns a rate remaining count' do
    expect(@rate['remaining']).to be_a(Fixnum)
  end
  
  it 'returns a rate reset time' do
    expect(@rate['reset']).to be_a(Fixnum)
  end
  
  it 'returns identical values for core and rate variables' do
    expect(@core['limit']).to eq(@rate['limit'])
    expect(@core['remaining']).to eq(@rate['remaining'])
    expect(@core['reset']).to eq(@rate['reset'])
  end
end

describe "Remaining requests variable" do
  before do
    @response = RestClient.get 'https://api.github.com/rate_limit'
    @rate_limit_hash = JSON.parse(@response.body)
    @core_remaining = @rate_limit_hash['resources']['core']['remaining']
    @rate_remaining = @rate_limit_hash['rate']['remaining']
  end
  
  # This test currently isn't working properly -- the second request is decreasing the counter, but not in the scope of the test  
  it 'decreases by one after each request' do
    new_request = JSON.parse(RestClient.get('https://api.github.com/rate_limit').body)
    expect(new_request['resources']['core']['remaining']).to eq(@core_remaining - 1)
    expect(new_request['rate']['remaining']).to eq(@rate_remaining - 1)
  end
end