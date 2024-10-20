class AddIndexToTasksUser < ActiveRecord::Migration[7.2]
  def change
    add_index :tasks, :user_id
  end
end
