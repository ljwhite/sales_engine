require 'rails_helper'

describe 'business intelligence' do
  before :each do
    @merchants = create_list(:merchant, 4)

    @invoice1 = create(:invoice, merchant_id: @merchants[0].id, updated_at: '2012-03-05')
      @invoice_item1 = create(:invoice_item, quantity: 1, unit_price: 100, invoice: @invoice1)
      @transaction1 = create(:transaction, invoice: @invoice1, updated_at: '2012-03-05')

    @invoice2 = create(:invoice, merchant_id: @merchants[1].id)
      @invoice_item2 = create(:invoice_item, quantity: 2, unit_price: 200, invoice: @invoice2)
      @transaction2 = create(:transaction, invoice: @invoice2)

    @invoice3 = create(:invoice, merchant_id: @merchants[2].id)
      @invoice_item3 = create(:invoice_item, quantity: 3, unit_price: 300, invoice: @invoice3)
      @transaction3 = create(:transaction, invoice: @invoice3)

    @invoice4 = create(:invoice, merchant_id: @merchants[3].id)
      @invoice_item4 = create(:invoice_item, quantity: 4, unit_price: 400, invoice: @invoice4)
      @transaction4 = create(:transaction, result: 'declined', invoice: @invoice4)
  end

  it 'list of merchants in order of revenue' do
    get "/api/v1/merchants/most_revenue?quantity=2"
    merchant_list = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_list[:data].first[:attributes][:name]).to eq(@merchants[2].name)
    expect(merchant_list[:data].count).to eq(2)
  end

  it 'can correctly determine if a transaction can disqualify revenue' do
    get "/api/v1/merchants/most_revenue?quantity=4"
    merchant_list = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_list[:data].count).to eq(3)
    expect(merchant_list[:data].last[:attributes][:name]).to eq(@merchants[0].name)
  end

  it "list of merchants with most items sold" do
    get "/api/v1/merchants/most_items?quantity=4"
    merchant_list = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_list[:data].count).to eq(3)
    expect(merchant_list[:data].first[:attributes][:name]).to eq(@merchants[2].name)
    expect(merchant_list[:data].second[:attributes][:name]).to eq(@merchants[1].name)
    expect(merchant_list[:data].last[:attributes][:name]).to eq(@merchants[0].name)
  end

  it 'can find total revenue across a date range' do
    start_date = '2012-03-04'
    end_date = '2012-03-06'
    get "/api/v1/revenue?start=#{start_date}&end=#{end_date}"
    binding.pry 
    revenue = JSON.parse(response.body, symbolize_names: true)
    expect(revenue[:data][:attributes][:revenue].to_i).to eq(100)
  end

  it 'can find revenue for a merchant' do
    merchant_id = @merchants.first.id
    get "/api/v1/merchants/#{merchant_id}/revenue"
    revenue = JSON.parse(response.body, symbolize_names: true)
    expect(revenue[:data][:attributes][:revenue].to_i).to eq(100)
  end

end
