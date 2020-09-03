class Api::V1::Merchants::ListItemsController < ApplicationController
  
  def index
    quantity = item_params[:quantity]
    render json: MerchantSerializer.new(Merchant.rank_merchants_by_items_sold(quantity))
  end

  private

  def item_params
    params.permit(:quantity)
  end
end
