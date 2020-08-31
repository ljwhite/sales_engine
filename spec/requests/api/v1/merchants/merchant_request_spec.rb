require 'rails_helper'

describe "Merchant API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)
    get '/api/v1/merchants'
    expect(response).to be_successful
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id
    get "/api/v1/merchants/#{id}"
    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can create a new merchant" do
    name = "Ians Oddities"
    merchant_params = {name: name}
    post "/api/v1/merchants", params: {merchant: merchant_params}
    merchant = Merchant.last
    expect(response).to be_successful
    expect(merchant.name).to eq(merchant_params[:name])
    expect(merchant.name).to eq("Ians Oddities")
  end

  it "can update an existing merchant" do
    original_merchant = create(:merchant)
    original_name = original_merchant.name
    new_name = "New Merchant Name"

    put "/api/v1/merchants/#{original_merchant.id}", params: {merchant: {name: new_name }}
    merchant = Merchant.last
    expect(response).to be_successful
    expect(merchant.name).to_not eq(original_name)
    expect(merchant.name).to eq(new_name)
  end

  it "can destroy an existing merchant" do
    merchant = create(:merchant)
    expect(Merchant.all.count).to eq(1)
    delete "/api/v1/merchants/#{merchant.id}"
    expect(response).to be_successful
    expect(Merchant.all.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
