class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :product_id
      t.string :brand
      t.integer :brand_id
      t.string :img_url
      t.string :buy_url
      t.string :category

      t.timestamps
    end
  end
end
