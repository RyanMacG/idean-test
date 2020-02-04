class CreateCurrencies < ActiveRecord::Migration[6.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :short_code

      t.timestamps
    end

    add_index(:currencies, :short_code, unique: true)
  end
end
