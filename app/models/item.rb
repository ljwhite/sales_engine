class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_by_params(params)
    if params[:name]
      where(Item.arel_table[:name].matches("%#{params[:name]}%")).first
    elsif params[:created_at]
      where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%").first
    elsif params[:updated_at]
      where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%").first
    end
  end

  def self.find_all_items_by_merchant(merchant)
    where(merchant_id: merchant.id)
  end
end
