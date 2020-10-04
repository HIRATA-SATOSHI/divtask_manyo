require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do
#   before do
#     factoryBot.create(:user)
#     factoryBot.create(:second_user)
#   end
  describe 'ユーザ登録のテスト' do
    context 'ユーザ登録がなくログインしていない場合' do
      it 'ユーザ新規登録のテスト' do
        visit new_user_path
        fill_in 'user_name', with: 'test_user_01'
        fill_in 'user_email', with: 'test_user_01@test.com'
        fill_in 'user_password', with: '12345678'
        fill_in 'user_password_confirmation', with: '12345678'
        click_on 'アカウント作成'
        expect(page).to have_content 'test_user_01'
      end
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'session機能テスト' do
    before do
      @user = FactoryBot.create(:user)
    end
    context "ログインしていない状態でユーザデータがある場合"
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on "Log in"
        expect(current_path).to eq user_path(id: @user.id)       
      end
    end

    context '一般ユーザでログインしている場合' do
      it '自分の詳細画面に飛べること' do
        visit user_path(id: @user.id)
        expect(page).to have_content 'test_user_01のページ'
        expect(page).to have_content 'メールアドレス : test_user_01@test.com'
      end  
      
      it "一般ユーザが他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        @admin_user = FactoryBot.create(:second_user)
        visit user_path(id: @admin_user.id)
        expect(page).to have_content "権限がありません。ログインしてください。"
      end

      it "ログアウトができること" do
        click_on 'Logout'
        expect(current_path).to eq root_path
      end      
    end


end


