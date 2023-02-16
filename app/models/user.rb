# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User
  has_many :tasks, dependent: :destroy
  scope :update_order, -> {order(updated_at: :desc)}

  def self.guest
    find_or_create_by!(email: "guest@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def self.guest_admin
    find_or_create_by!(email: "admin@example.com") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "管理者ユーザー"
      user.admin = true
    end
  end
end
