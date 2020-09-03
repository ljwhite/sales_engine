require 'rails_helper'

describe 'Item single result query param spec' do
  before :each do
    @merchant1 = create(:merchant, name: "Ians Oddities")
    @item1 = create(:item, name: "3d keychains", merchant: @merchant1, description: "Easy to lose your keys in 2d")
    @item2 = create(:item, name: "Key Ring", merchant: @merchant1, created_at: DateTime.new(2000,9,1,8,37,48, "-06:00"), unit_price: 555.55)
    @item3 = create(:item, name: "Chain Storage", merchant: @merchant1, created_at: DateTime.new(2010,9,1,8,37,48, "-06:00"), updated_at: DateTime.new(2016,9,1,8,37,48, "-06:00"))
  end

  it 'can find a single result provided a partial of a name' do
    query = "3d+keychain"
    get "/api/v1/items/find?name=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq("3d keychains")
    expect(item[:data][:id].to_i).to eq(@item1.id)
  end

  it 'the partial can be any part of the name, and is case insensitive' do
    query = "EYCH"
    get "/api/v1/items/find?name=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item1.name)
    expect(item[:data][:id].to_i).to eq(@item1.id)
  end

  it 'can find a single result provided a created_at attribute' do
    query = "2000-09-01"
    get "/api/v1/items/find?created_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item2.name)
    expect(item[:data][:id].to_i).to eq(@item2.id)
  end

  it 'can find a single result provided an updated_at attribute' do
    query = "2016-09-01"
    get "/api/v1/items/find?updated_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item3.name)
    expect(item[:data][:id].to_i).to eq(@item3.id)
  end

  it 'can find a single result provided a partial created_at attribute' do
    query = "00-09"
    get "/api/v1/items/find?created_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item2.name)
    expect(item[:data][:id].to_i).to eq(@item2.id)
  end

  it 'can find a single result provided a partial updated_at attribute' do
    query = "16-09"
    get "/api/v1/items/find?updated_at=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item3.name)
    expect(item[:data][:id].to_i).to eq(@item3.id)
  end

  it 'can find a single result provided a case-insensitive partial description' do
    query = "sE+Yo"
    get "/api/v1/items/find?description=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item1.name)
    expect(item[:data][:id].to_i).to eq(@item1.id)
  end

  it 'can find a single result provided a unit price' do
    query = "555.55"
    get "/api/v1/items/find?unit_price=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item2.name)
    expect(item[:data][:id].to_i).to eq(@item2.id)
  end

  it 'can find a single result provided a merchant id' do
    query = @merchant1.id
    get "/api/v1/items/find?merchant_id=#{query}"
    item = JSON.parse(response.body, symbolize_names: true)
    expect(item[:data][:attributes][:name]).to eq(@item1.name)
    expect(item[:data][:id].to_i).to eq(@item1.id)
  end
end
