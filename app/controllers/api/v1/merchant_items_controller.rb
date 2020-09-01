class Api::V1::MerchantItemsController < ApplicationController

  def index
    merchant = Merchant.find(params[:id])
    render json: ItemSerializer.new(Item.find_all_items_by_merchant(merchant))
  end

  def show
    item = Item.find(params[:id])
    render json: MerchantSerializer.new(Merchant.find(item.merchant_id))
  end
end
