require 'rails_helper'

describe 'list all items of a merchant' do
  before :each do
    @merchant1 = create(:merchant)
    @items_one = create_list(:item, 3, merchant: @merchant1)
    @merchant2 = create(:merchant)
    @items_two = create_list(:item, 5, merchant: @merchant2)
  end

  it 'can return all items associated witha  merchant' do
    get "/api/v1/merchants/#{@merchant1.id}/items"
    merchant_items = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_items[:data].count).to eq(@items_one.count)
  end
end
