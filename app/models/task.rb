class Task < ApplicationRecord
  belongs_to :user
  has_many :task_categories, dependent: :destroy
  has_many :task_categories_info,through: :task_categories, source: :category
  scope :recent_order, -> {order(created_at: :desc)}
  validates :name, presence: true, length: {maximum: 50}
  validates :content, presence: true, length: {maximum: 255}
  validates :limit, presence: true
end