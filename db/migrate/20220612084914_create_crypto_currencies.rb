class CreateCryptoCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :cryptocurrencies do |t|
      t.string :name
      t.string :symbol
      t.json :display_data
      t.json :raw_data

      t.timestamps
    end
  end
end
