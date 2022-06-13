class CreateCryptocurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :crypto_currencies do |t|
      t.string :name, null: false
      t.string :symbol, null: false
      t.json :display_data
      t.json :raw_data

      t.timestamps
    end
  end
end
