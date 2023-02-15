class Task < ApplicationRecord
  belongs_to :user
  has_many :memos, dependent: :destroy
  has_many :task_categories, dependent: :destroy
  has_many :task_categories_info,through: :task_categories, source: :category
end