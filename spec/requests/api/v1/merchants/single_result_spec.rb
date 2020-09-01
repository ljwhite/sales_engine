require 'rails_helper'

describe 'Merchant API' do
  before :each do
    @merchant1 = create(:merchant, name: "Ians Oddities")
    @merchant2 = create(:merchant, name: "Diones Haberdashery", created_at: DateTime.new(2000,9,1,8,37,48, "-06:00"))
    @merchant3 = create(:merchant, name: "Megs Musings", created_at: DateTime.new(2010,9,1,8,37,48, "-06:00"), updated_at: DateTime.new(2016,9,1,8,37,48, "-06:00"))
  end

  it 'can find a single result provided a partial of a name' do
    query = "ian"
    get "/api/v1/merchants/find?name=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq("Ians Oddities")
    expect(merchant[:data][:id].to_i).to eq(@merchant1.id)
  end

  it 'the partial can be any part of the name, and is case insensitive' do
    query = "DITI"
    get "/api/v1/merchants/find?name=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq("Ians Oddities")
    expect(merchant[:data][:id].to_i).to eq(@merchant1.id)
  end

  it 'can find a single result provided a created_at attribute' do
    query = "2000-09-01"
    get "/api/v1/merchants/find?created_at=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant2.name)
    expect(merchant[:data][:id].to_i).to eq(@merchant2.id)
  end

  it 'can find a single result provided an updated_at attribute' do
    query = "2016-09-01"
    get "/api/v1/merchants/find?updated_at=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant3.name)
    expect(merchant[:data][:id].to_i).to eq(@merchant3.id)
  end

  it 'can find a single result provided a partial created_at attribute' do
    query = "00-09"
    get "/api/v1/merchants/find?created_at=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant2.name)
    expect(merchant[:data][:id].to_i).to eq(@merchant2.id)
  end

  it 'can find a single result provided a partial updated_at attribute' do
    query = "16-09"
    get "/api/v1/merchants/find?updated_at=#{query}"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant3.name)
    expect(merchant[:data][:id].to_i).to eq(@merchant3.id)
  end
end
