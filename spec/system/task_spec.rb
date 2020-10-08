require 'rails_helper'
RSpec.describe 'タスク一覧画面', type: :system do

  before do
    @user = FactoryBot.create(:user)
    visit new_session_path
    fill_in 'session_email', with:'test_user_01@test.com'
    fill_in 'session_password', with:'12345678'
    click_on 'Log in'
    FactoryBot.create(:task, user: @user)
    FactoryBot.create(:second_task, user: @user)
    FactoryBot.create(:third_task, user: @user)
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "task_name", with: "test"
        fill_in "task_detail", with: "Factoryで作ったデフォルトのコンテント1"
        fill_in "task_deadline", with: "2020-10-30"
        select "進行中", from: "task_status"
        select "高", from: "task_priority"
        click_on "登録する"
        expect(page).to have_content "test"
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント3'  
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list= all('.task_list')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル3'             
      end
    end

    context 'タスク一覧で終了期限ボタンをクリックすると' do
      it '終了期限の降順に並び変えられたタスク一覧が表示される' do     
        visit tasks_path
        click_link '終了期限でソートする' 
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル3'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル2'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル1'
      end
    end

    context 'タスク一覧で優先順位ボタンをクリックした場合' do
      it '優先順位の降順に並び替えられたタスク一覧が表示される' do
        visit tasks_path
        click_link '優先度高い順でソート'
        sleep 0.5
        tasks_path(sort_priority_high: "true")
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル1'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル2'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル3'   
      end
    end
  end
    
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
      end
    end
  end

  describe '検索機能' do
    before do
      FactoryBot.create(:task, name: "Factoryで作ったデフォルトのタイトル1", status: "completed", user: @user)
      FactoryBot.create(:second_task, name: "Factoryで作ったデフォルトのタイトル2", user: @user)
    end
    
    context 'タイトルであいまい検索をかける' do
      it '検索ワードを含むタスクで絞り込まれる' do
        fill_in "task_name", with: "Factoryで作った"
        click_on "検索"
        expect(page).to have_content 'Factoryで作ったデフォルトのタイトル1'
        expect(page).not_to have_content 'sample'
      end
    end

    context 'ステータス検索した場合' do
      it "ステータス検索をした場合" do
        visit tasks_path
        select "未着手", from: "task_status"
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it '検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる' do
        visit tasks_path
        fill_in "task_name", with: "Factoryで作った"
        select "未着手", from: "task_status"
        click_on '検索'
        expect(page).to have_content 'Factoryで作った'
        expect(page).to have_content '未着手'       
      end
    end

  end
  
end