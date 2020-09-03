require 'rails_helper'

describe 'Item multi_finder' do
  before :each do
    @merchant1 = create(:merchant, name: "Ians Oddities")
    @item1 = create(:item, name: "3d keychains", merchant: @merchant1, unit_price: 100.50, description: "Cold to the touch")
    @item2 = create(:item, name: "Key Ring", merchant: @merchant1, created_at: DateTime.new(2010,9,1,8,37,48, "-06:00"), unit_price: 100.50, description: "Bold touch")
    @item3 = create(:item, name: "Chain Storage", merchant: @merchant1, created_at: DateTime.new(2010,9,1,8,37,48, "-06:00"), updated_at: DateTime.new(2016,9,1,8,37,48, "-06:00"))
  end

  it 'can find multiple results provided a case-insensitive partial of a name' do
    query = "kEY"
    get "/api/v1/items/find_all?name=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results provided a case-insensitive partial of a name' do
    query = "kEY"
    get "/api/v1/items/find_all?name=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results provided a created_at date' do
    query = "2010-09-01"
    get "/api/v1/items/find_all?created_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results provided a partial created_at date' do
    query = "10-09-0"
    get "/api/v1/items/find_all?created_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results provided an updated_at date' do
    query = "2016-09-01"
    get "/api/v1/items/find_all?updated_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(1)
  end

  it 'can find multiple results provided a partial updated_at date' do
    query = "6-0"
    get "/api/v1/items/find_all?updated_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(1)
  end

  it 'can find multiple results provided a unit_price' do
    query = "100.50"
    get "/api/v1/items/find_all?unit_price=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results provided a case-insensitive partial description' do
    query = "oLD+tO"
    get "/api/v1/items/find_all?description=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(2)
  end

  it 'can find multiple results based off a merchant_id' do
    query = @merchant1.id
    get "/api/v1/items/find_all?merchant_id=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data].count).to eq(3)
  end

end
