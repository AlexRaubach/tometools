class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.integer :ratings_count
      t.string :small_image_url
      t.string :image_url
      t.integer :average_rating
      t.string :author
      t.text :description
      t.integer :goodsreads_id, { null: false, uniqueness: true }

      t.timestamps(null: false)
    end
  end
end
