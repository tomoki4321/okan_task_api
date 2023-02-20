class DropMemos < ActiveRecord::Migration[6.1]
  def change
    drop_table :memos do |t|
      t.string :name
      t.references :task, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
