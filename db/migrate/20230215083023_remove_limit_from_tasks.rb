class RemoveLimitFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :limit, :date
  end
end
