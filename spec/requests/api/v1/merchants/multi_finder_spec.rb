require 'rails_helper'

describe 'Merchant API multi-finder' do
  before :each do
    @merchant1 = create(:merchant, name: "Ions Oddities")
    @merchant2 = create(:merchant, name: "Diones Haberdashery", created_at: DateTime.new(2010,9,1), updated_at: DateTime.new(2016,9,1))
    @merchant3 = create(:merchant, name: "Megs Musings", created_at: DateTime.new(2010,9,1), updated_at: DateTime.new(2016,9,1))
  end

  it 'can find multiple results provided a case_insensitive partial of a name' do
    query = "iON"
    get "/api/v1/merchants/find_all?name=#{query}"
    list = JSON.parse(response.body, symbolize_names: true)
    expect(list[:data].first[:attributes][:name]).to eq("Ions Oddities")
    expect(list[:data].count).to eq(2)
    expect(list).to_not include("Megs Musings")
  end

  it 'can find multiple results provided a created_at date' do
    query = "2010-09-01"
    get "/api/v1/merchants/find_all?created_at=#{query}"
    list = JSON.parse(response.body, symbolize_names: true)
    expect(list[:data].first[:attributes][:name]).to eq("Diones Haberdashery")
    expect(list[:data].count).to eq(2)
    expect(list).to_not include("Ions Oddities")
  end

  it 'can find multiple results provided an updated_at date' do
    query = "2016-09-01"
    get "/api/v1/merchants/find_all?updated_at=#{query}"
    list = JSON.parse(response.body, symbolize_names: true)
    expect(list[:data].first[:attributes][:name]).to eq("Diones Haberdashery")
    expect(list[:data].count).to eq(2)
    expect(list).to_not include("Ions Oddities")
  end

  it 'can find multiple results provided a partial created_at date' do
    query = "010-0"
    get "/api/v1/merchants/find_all?created_at=#{query}"
    list = JSON.parse(response.body, symbolize_names: true)
    expect(list[:data].first[:attributes][:name]).to eq("Diones Haberdashery")
    expect(list[:data].count).to eq(2)
    expect(list).to_not include("Ions Oddities")
  end

  it 'can find multiple results provided a partial updated_at date' do
    query = "16-09"
    get "/api/v1/merchants/find_all?updated_at=#{query}"
    list = JSON.parse(response.body, symbolize_names: true)
    expect(list[:data].first[:attributes][:name]).to eq("Diones Haberdashery")
    expect(list[:data].count).to eq(2)
    expect(list).to_not include("Ions Oddities")
  end
end
