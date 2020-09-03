# README

Ruby: 2.5.3
Rails: 5.2.4.3

Setup Instructions:
- After cloning, run bundle, then db:{create, migrate}
- All seed data is held in a collection of csv files in db/csv.
- Run the following rake commands from the command line to seed the data:
  - rake seed_csv_data:create_customers
  - rake seed_csv_data:create_merchants
  - rake seed_csv_data:create_items
  - rake seed_csv_data:create_invoices
  - rake seed_csv_data:create_invoice_items
  - rake seed_csv_data:create_transactions


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
