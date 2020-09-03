class Api::V1::RevenueController < ApplicationController
  
  def show
    start_date = params[:start]
    end_date = params[:end]
    render json: RevenueSerializer.new(RevenueFacade.revenue_between_dates(start_date, end_date))
  end

  private

  def revenue_params
    params.permit(:start, :end)
  end
end
