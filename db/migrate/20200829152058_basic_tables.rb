class BasicTables < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.timestamps
    end

    create_table :merchants do |t|
      t.string :name
      t.timestamps
    end

    create_table :items do |t|
      t.string :name
      t.string :description
      t.float :unit_price
      t.integer :merchant_id
      t.timestamps
    end
    add_index :items, :merchant_id

    create_table :invoices do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.string :status
      t.timestamps
    end
    add_index :invoices, :merchant_id
    add_index :invoices, :customer_id

    create_table :invoice_items do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.float :unit_price
      t.timestamps
    end
    add_index :invoice_items, :invoice_id
    add_index :invoice_items, :item_id

    create_table :transactions do |t|
      t.integer :invoice_id
      t.bigint :credit_card_number
      t.date :credit_card_expiration_date
      t.string :result
      t.timestamps
    end
    add_index :transactions, :invoice_id
  end
end
