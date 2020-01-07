class AddUserToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_index :tasks, [:user_id, :created_at]
  end
end
