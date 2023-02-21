class Task < ApplicationRecord
  belongs_to :user
  has_many :memos, dependent: :destroy
  has_many :task_categories, dependent: :destroy
  has_many :task_categories_info,through: :task_categories, source: :category
  scope :recent_order, -> {order(created_at: :desc)}
  validates :name, presence: true
  validates :content, presence: true
  validates :limit, presence: true
end