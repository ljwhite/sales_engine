class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.find_all_by_params(merchant_params))
  end

  def show
    render json: MerchantSerializer.new(Merchant.find_by_params(merchant_params))
  end

  private

  def merchant_params
    params.permit(:name, :updated_at, :created_at)
  end
end
