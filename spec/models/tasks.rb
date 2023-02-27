require 'rails_helper'
RSpec.describe 'Task', type: :model do
  describe 'タスクバリデーション' do
    context 'タスクの名前と内容と期限が入力されている場合' do
      it 'タスクの登録に成功する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"テスト",content:"テスト内容",limit:Date.today,user_id:user.id)
        expect(task).to be_valid
      end
    end
    context 'タスクの名前が空の場合' do
      it 'タスク登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"",content:"テスト内容",limit:Date.today,user_id:user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの内容が空の場合' do
      it 'タスク登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"テスト",content:"",limit:Date.today,user_id:user.id)
        expect(task).not_to be_valid
      end
    end
    context '期限の内容が空の場合' do
      it 'タスク登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"テスト",content:"テスト内容",limit:"",user_id:user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの名前が５５文字以上の場合' do
      it 'タスク登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"テスト"*20,content:"テスト内容",limit:Date.today,user_id:user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクの名前が２５５文字以上の場合' do
      it 'タスク登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        task = Task.create(name:"テスト",content:"テスト内容"*60,limit:Date.today,user_id:user.id)
        expect(task).not_to be_valid
      end
    end
  end
  describe "scopeテスト" do
    let!(:user){ FactoryBot.create(:user)}
    let!(:task2){ FactoryBot.create(:task2,user: user)}
    let!(:task3){ FactoryBot.create(:task3,user: user)}
    context "タスクを取得した場合" do
      it "作成順になる" do
        expect(Task.recent_order).to eq(Task.order(created_at: :desc))
      end
    end
  end
end