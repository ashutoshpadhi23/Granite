class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.text :title, null: false
      t.timestamps
    end
  end
end
