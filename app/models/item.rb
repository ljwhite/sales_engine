class Item < ApplicationRecord
  belongs_to :merchant

  def self.find_by_params(params)
    if params[:name]
      Item.where(Item.arel_table[:name].matches("%#{params[:name]}%")).first
    elsif params[:created_at]
      Item.where("to_char(created_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:created_at]}%").first
    elsif params[:updated_at]
      Item.where("to_char(updated_at, 'YYYY-MM-DD') LIKE ?", "%#{params[:updated_at]}%").first
    end
  end
end
