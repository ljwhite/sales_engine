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

  def self.find_all_by_params(params)
    if params[:name]
      where(Merchant.arel_table[:name].matches("%#{params[:name]}%"))
    elsif params[:created_at]
      where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%")
    elsif params[:updated_at]
      where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%")
    end
  end

  def self.find_by_item(item)
    find(item.merchant_id)
  end

  def self.rank_merchants_by_revenue(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items]).where(invoices: {status: 'shipped'}).where(transactions: {result: 'success'}).select('merchants.id, merchants.name, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue').group(:id).order('revenue DESC').limit(quantity)
  end

  def self.rank_merchants_by_items_sold(quantity)
    Merchant.joins(invoices: [:transactions, :invoice_items]).where(transactions: {result: 'success'}).select('merchants.id, merchants.name, SUM( invoice_items.quantity) AS items_sold').group(:id).order('items_sold DESC').limit(quantity)
  end

  def self.find_merchant_total_revenue(merchant_id)
    Merchant.joins(invoices: [:invoice_items, :transactions]).select('merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue').where(invoices: {status: 'shipped'}).where(transactions: {result: 'success'}).where({id: merchant_id}).group(:id)
  end
end
