class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.belongs_to :from_currency, index: true, null: false, foreign_key: { to_table: :currencies }
      t.belongs_to :to_currency, index: true, null: false, foreign_key: { to_table: :currencies }
      t.float :conversion_rate
      t.integer :amount_purchased
      t.text :denominations, array: true, default: []

      t.timestamps
    end
  end
end
