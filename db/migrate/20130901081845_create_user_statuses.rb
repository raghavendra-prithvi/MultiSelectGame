class CreateUserStatuses < ActiveRecord::Migration
  def change
    create_table :user_statuses do |t|
      t.integer :right_answers
      t.integer :wrong_answers
      t.integer :invited
      t.boolean :shared_on_fb, :default => false
      t.boolean :buyed, :default => false

      t.timestamps
    end
  end
end
