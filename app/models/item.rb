class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  # has_many :transactions, through: :invoices

  def self.find_by_params(params)
    if params[:name]
      where(Item.arel_table[:name].matches("%#{params[:name]}%")).first
    elsif params[:description]
      where(Item.arel_table[:description].matches("%#{params[:description]}%")).first
    elsif params[:unit_price]
      where(unit_price: params[:unit_price]).first
    elsif params[:merchant_id]
      where(merchant_id: params[:merchant_id]).first
    elsif params[:created_at]
      where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%").first
    elsif params[:updated_at]
      where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%").first
    end
  end

  def self.find_all_by_params(params)
    if params[:name]
      where(Item.arel_table[:name].matches("%#{params[:name]}%"))
    elsif params[:description]
      where(Item.arel_table[:description].matches("%#{params[:description]}%"))
    elsif params[:unit_price]
      where(unit_price: params[:unit_price])
    elsif params[:merchant_id]
      where(merchant_id: params[:merchant_id])
    elsif params[:created_at]
      where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%")
    elsif params[:updated_at]
      where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%")
    end
  end

  def self.find_all_items_by_merchant(merchant)
    where(merchant_id: merchant.id)
  end
end
