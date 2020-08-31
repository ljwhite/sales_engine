FactoryBot.define do
  factory :customer do
    first_name { "John" }
    sequence(:last_name) { |n| "Doe #{n}"}
  end

  factory :merchant do
    sequence(:name) { |n| "Merchant #{n}"}
  end

  factory :item do
    merchant
    sequence(:name) { |n| "Item #{n}"}
    description { "Great item" }
    unit_price { 101.50 }
  end

  factory :invoice do
    customer
    merchant
    status { "Processing" }
  end

  factory :invoice_item do
    invoice
    item
    quantity { 1 }
    unit_price { 101.50 }
  end

  factory :transaction do
    invoice
    credit_card_number { 1234567812345678 }
    credit_card_expiration_date { Date.tomorrow }
    result { "Approved" }
  end
end
