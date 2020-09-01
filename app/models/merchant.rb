class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.find_by_params(params)
    if params[:name]
      where(Merchant.arel_table[:name].matches("%#{params[:name]}%")).first
    elsif params[:created_at]
      where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%").first
    elsif params[:updated_at]
      where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%").first
    end
  end

  def self.find_by_item(item)
    find(item.merchant_id)
  end
end
