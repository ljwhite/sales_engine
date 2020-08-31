require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)
    get '/api/v1/items'
    expect(response).to be_successful
    items = JSON.parse(response.body)
    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id
    get "/api/v1/items/#{id}"
    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can create a new item" do
    name = "3D keychain"
    merchant = create(:merchant)
    item_params = {name: name, description: "Better than 2D", unit_price: 5.50, merchant_id: merchant.id }
    post "/api/v1/items", params: {item: item_params}
    item = Item.last
    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.name).to eq("3D keychain")
  end

  it "can update an existing merchant" do
    original_item = create(:item)
    original_name = original_item.name
    new_name = "New Item Name"

    put "/api/v1/items/#{original_item.id}", params: {item: {name: new_name }}
    item = Item.last
    expect(response).to be_successful
    expect(item.name).to_not eq(original_name)
    expect(item.name).to eq(new_name)
  end

  it "can destroy an existing merchant" do
    item = create(:item)
    expect(Item.all.count).to eq(1)
    delete "/api/v1/items/#{item.id}"
    expect(response).to be_successful
    expect(Item.all.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
