require 'spec_helper'

describe 'Github zen endpoint request' do
  before do
    @response = RestClient.get('https://api.github.com/zen')
  end

  it "returns a response code" do
    expect(@response.code).to eq(200)
  end
  
  it "returns a string" do
    expect(@response).to be_kind_of(String)
  end
end