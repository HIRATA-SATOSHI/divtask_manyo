class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :date
  end
end
