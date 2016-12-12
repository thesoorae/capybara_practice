class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :goal_text, null:false
      t.integer :user_id
      t.string :visibility, null: false
      t.boolean :completed, null:false, default:false

      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
