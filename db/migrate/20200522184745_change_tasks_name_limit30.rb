class ChangeTasksNameLimit30 < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, limit: 30
  end
  def down
    change_column :tasks, :name, :string
  end
end
