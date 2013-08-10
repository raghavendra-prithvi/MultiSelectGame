class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :img_url
      t.integer :ans

      t.timestamps
    end
  end
end
