require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    visit new_session_path
    fill_in 'session_email', with:'test_user_01@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
  end

  describe 'ラベル管理' do
    context'ラベルを作成した際' do
      it 'ラベルが作成できる' do
      visit new_label_path
      fill_in 'label_name', with: '開発'
      click_on '登録する'
      expect(page).to have_content '開発'
      end
    end

    context'タスクにラベルが付けられる' do
        it 'タスクを新規に作成' do
        visit new_task_path
        fill_in "task_name", with: "test"
        fill_in "task_detail", with: "Factoryで作ったデフォルトのコンテント1"
        fill_in "task_deadline", with: "2020-10-30"
        select "進行中", from: "task_status"
        select "高", from: "task_priority"
        check 'task_label_ids_3'
        click_on "登録する"
        end
      end

    context 'ラベルで絞り込んで検索した場合' do
      it 'ラベルで検索が絞り込まれる' do
        visit tasks_path
        select '開発', from: 'task_label_id'
        click_on '検索'
        expect(page).to have_content '開発'
      end
    end
  end
end
  
