class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.integer :book_id
      t.string :cost

      t.timestamps(null: false)
    end
  end
end
