class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :isbn
      t.string :title
      t.integer :ratings_count
      t.string :small_image_url
      t.string :image_url
      t.integer :average_rating
      t.string :author
      t.text :description

  end
end
