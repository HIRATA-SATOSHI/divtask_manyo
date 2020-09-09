class AddIndexTasksName < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :name
  end
end
