class CreateDenominations < ActiveRecord::Migration[6.0]
  def change
    create_table :denominations do |t|
      t.integer :amount
      t.integer :stock
      t.belongs_to :currency, null: false, foreign_key: true

      t.timestamps
    end
  end
end
