require 'csv'

desc 'it seeds data from db/csv/ files'
namespace :seed_csv_data do
  task create_customers: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    CSV.foreach('db/csv/customers.csv', headers: true) do |row|
      Customer.create(
        first_name: row["first_name"],
        last_name: row["last_name"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end

  task create_merchants: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    CSV.foreach('db/csv/merchants.csv', headers: true) do |row|
      Merchant.create(
        name: row["name"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end

  task create_items: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    CSV.foreach('db/csv/items.csv', headers: true) do |row|
      Item.create(
        name: row["name"],
        description: row["description"],
        unit_price: row["unit_price"].to_f/100,
        merchant_id: row["merchant_id"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end

  task create_invoices: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    CSV.foreach('db/csv/invoices.csv', headers: true) do |row|
      Invoice.create(
        customer_id: row["customer_id"],
        merchant_id: row["merchant_id"],
        status: row["status"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end

  task create_invoice_items: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    CSV.foreach('db/csv/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(
        item_id: row["item_id"],
        invoice_id: row["invoice_id"],
        quantity: row["quantity"],
        unit_price: row["unit_price"].to_f/100,
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end

  task create_transactions: :environment do
    ActiveRecord::Base.connection.reset_pk_sequence!('transaction')
    CSV.foreach('db/csv/transactions.csv', headers: true) do |row|
      Transaction.create(
        invoice_id: row["invoice_id"],
        credit_card_number: row["credit_card_number"],
        credit_card_expiration_date: row["credit_card_expiration_date"],
        result: row["result"],
        created_at: row["created_at"],
        updated_at: row["updated_at"]
      )
    end
  end


end
