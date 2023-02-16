class AddLimitToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :limit, :string
  end
end
