class RemoveLimitAgain < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :limit, :string
  end
end
