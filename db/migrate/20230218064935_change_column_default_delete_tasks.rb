class ChangeColumnDefaultDeleteTasks < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :limit, nil
  end
end
