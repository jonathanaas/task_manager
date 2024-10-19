class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :status
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
