require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let!(:user){ FactoryBot.create(:user)}
  let!(:task1){ FactoryBot.create(:task1,user: user)}
  let!(:category){ FactoryBot.create(:category)}
  let!(:task_category){ FactoryBot.create(:task_category,task: task1,category: category)}
  describe "新規投稿" do
    it "タスクを投稿できる" do
      auth_tokens = sign_in(user)
      params={ task:{name: "テスト",content:"テスト内容",limit:Date.today,status:2,priority:2,progress:20}}
      post api_v1_tasks_path,params: params, headers: auth_tokens
      expect(response.status).to eq 201
    end
  end
  describe "詳細機能" do
    it "タスクの詳細が見れる" do
      auth_tokens = sign_in(user)
      get api_v1_task_path(task1.id),headers: auth_tokens
      expect(response.status).to eq 200
    end
  end
  describe "削除機能" do
    it "タスクを削除できる" do
      auth_tokens = sign_in(user)
      delete api_v1_task_path(task1.id),headers: auth_tokens
      expect(response.status).to eq 200
    end
  end
  describe "更新機能" do
    it "タスクを更新できる" do
      auth_tokens = sign_in(user)
      params={ task:{name: "テスト",content:"テスト内容",limit:Date.today,status:2,priority:2,progress:20}}
      patch api_v1_task_path(task1.id),params: params,headers: auth_tokens
      expect(response.status).to eq 201
    end
  end
  describe "ラベル追加" do
    it "ラベルを追加できる" do
      auth_tokens = sign_in(user)
      params={task_category: {task_id:task1.id,category_id: category.id}}
      post label_add_api_v1_tasks_path,params: params, headers: auth_tokens
      expect(response.status).to eq 201
    end
  end
  describe "ラベル取得" do
    it "ラベルを取得できる" do
      auth_tokens = sign_in(user)
      get label_find_api_v1_task_path(task1.id),headers: auth_tokens
      expect(response.status).to eq 200
    end
  end
end
