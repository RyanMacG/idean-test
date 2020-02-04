class CreateConversionRates < ActiveRecord::Migration[6.0]
  def change
    create_table :conversion_rates do |t|
      t.float :rate
      t.belongs_to :from_currency, index: true, null: false, foreign_key: { to_table: :currencies }
      t.belongs_to :to_currency, index: true, null: false, foreign_key: { to_table: :currencies }

      t.timestamps
    end
  end
end
