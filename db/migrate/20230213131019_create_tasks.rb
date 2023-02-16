class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.string :content
      t.date :limit
      t.integer :priority
      t.integer :status
      t.integer :progress

      t.timestamps
    end
  end
end
