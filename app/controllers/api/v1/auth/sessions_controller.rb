class Api::V1::SessionsController < DeviseTokenAuth::SessionsController

  def guest_sign_in
    @resource = User.guest
    @token = @resource.create_token
    @resource.save!
    render_create_success
  end

  def admin_sign_in
    @resource = User.guest_admin
    @token = @resource.create_token
    @resource.save!
    render_create_success
  end

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
