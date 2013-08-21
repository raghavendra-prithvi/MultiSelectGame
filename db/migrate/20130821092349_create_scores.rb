class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :points, :limit => 8
      t.integer :user_id, :limit => 16
      t.string :remarks

      t.timestamps
    end
  end
end
