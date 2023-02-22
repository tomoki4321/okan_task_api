require 'rails_helper'


RSpec.describe User, type: :request do
  let!(:user){ FactoryBot.create(:user)}
  let!(:user2){ FactoryBot.create(:user2)}
  let!(:admin_user){ FactoryBot.create(:admin_user)}
  describe "一覧機能" do
    it "管理者ユーザーはユーザー情報を取得出来る" do
      auth_tokens = sign_in(admin_user)
      get api_v1_admin_users_path, headers: auth_tokens
      expect(response.status).to eq 200
    end

    it "一般ユーザーはユーザー情報を取得出来ない" do
      auth_tokens = sign_in(user)
      get api_v1_admin_users_path, headers: auth_tokens
      expect(response.status).to eq 401
    end
  end

  describe "ユーザー情報更新機能" do
    it "管理者ユーザーはユーザー情報を更新できる" do
      auth_tokens = sign_in(admin_user)
      params={ user:{name: "user3",email: "user3@example.com",password: "password3"}}
      patch api_v1_admin_user_path(user2.id), params: params, headers: auth_tokens
      expect(response.status).to eq 200
    end

    it "一般ユーザーはユーザー情報を更新できない" do
      auth_tokens = sign_in(user)
      params={ user:{name: "user3",email: "user3@example.com",password: "password3"}}
      patch api_v1_admin_user_path(user2.id), params: params, headers: auth_tokens
      expect(response.status).to eq 401
    end
  end

  describe "削除機能" do
    it "管理者ユーザーはユーザーを削除出来る" do
      auth_tokens = sign_in(admin_user)
      delete api_v1_admin_user_path(user2.id), headers: auth_tokens
      expect(response.status).to eq 200
    end

    it "一般ユーザーはユーザーを削除出来ない" do
      auth_tokens = sign_in(user)
      delete api_v1_admin_user_path(user2.id), headers: auth_tokens
      expect(response.status).to eq 401
    end
  end

end

