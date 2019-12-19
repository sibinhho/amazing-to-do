class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :category
      t.string :deadline
      t.boolean :done
      t.string :name
      t.timestamps
    end
  end
end
