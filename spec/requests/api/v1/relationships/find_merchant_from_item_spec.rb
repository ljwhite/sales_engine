require 'rails_helper'

describe 'show merchant by item' do
  before :each do
    @merchant1 = create(:merchant)
    @items_one = create_list(:item, 3, merchant: @merchant1)
    @item1 = @items_one.first
    @merchant2 = create(:merchant)
    @items_two = create_list(:item, 5, merchant: @merchant2)
  end

  it 'looking for a particular item can return the merchant info' do
    get "/api/v1/items/#{@item1.id}/merchant"
    merchant = JSON.parse(response.body, symbolize_names: true)
    expect(merchant[:data][:attributes][:name]).to eq(@merchant1.name)
  end
end
