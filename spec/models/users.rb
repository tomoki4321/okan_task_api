require 'rails_helper'
RSpec.describe 'User', type: :model do
  describe 'ユーザーバリデーション' do
    context 'ユーザーのemailとパスワードが入力されている場合' do
      it 'ユーザー登録に成功する' do
        user = User.create(email: 'test@gmail.com', password: 'password', password_confirmation: 'password')
        expect(user).to be_valid
      end
    end
    context 'ユーザーのパスワードが空文字の場合' do
      it 'ユーザー登録に失敗する' do
        user = User.create(email: 'test@gmail.com', password: '', password_confirmation: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーのemail空の場合' do
      it 'ユーザー登録に失敗する' do
        user = User.create(email: '', password: 'password', password_confirmation: 'password')
        expect(user).not_to be_valid
      end
    end
  end
end
