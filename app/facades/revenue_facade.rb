class RevenueFacade

  def self.revenue_between_dates(start_date, end_date)
    revenue = InvoiceItem
      .joins(invoice: :transactions)
      .where(
        transactions: {result: 'success'},
        invoices: {status: 'shipped', updated_at:   Date.parse(start_date).beginning_of_day..Date.parse(end_date).end_of_day}
      )
      .sum('invoice_items.quantity * invoice_items.unit_price')
    Revenue.new(revenue)
  end

  def self.merchant_revenue(id)
    revenue_array = Merchant
    .joins(invoices: [:invoice_items, :transactions])
    .select('merchants.id, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue')
    .where(
      invoices: {status: 'shipped'},
      transactions: {result: 'success'},
      merchants: {id: id}
    )
    .group(:id)

    revenue = revenue_array.first.merchant_revenue
    Revenue.new(revenue)
  end
end
