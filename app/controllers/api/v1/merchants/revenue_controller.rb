class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    quantity = revenue_params[:quantity]
    render json: MerchantSerializer.new(Merchant.rank_merchants_by_revenue(quantity))
  end

  def show
    id = revenue_params[:id]
    render json: RevenueSerializer.new(RevenueFacade.merchant_revenue(id))
  end

  private

  def revenue_params
    params.permit(:quantity, :id)
  end
end
