class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices

  def self.find_by_params(params)
    if params[:name]
      Merchant.where(Merchant.arel_table[:name].matches("%#{params[:name]}%")).first
    elsif params[:created_at]
      Merchant.where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%").first
    elsif params[:updated_at]
      Merchant.where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%").first
    end
  end
end
