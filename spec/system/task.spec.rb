require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  # let!(:task) = FactoryBot.create(:task, name: 'task')
  before do
    # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
    visit tasks_path
  end

  # before do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  #   Task.create!(name: 'test_task_01', detail: 'test_content_01')
  #   Task.create!(name: 'test_task_02', detail: 'test_content_01')
  # end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:second_task, name: 'task')
        task = FactoryBot.create(:second_task, name: 'task2')
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        expect(page).to_not have_content 'Factoryで作ったデフォルトのコンテント3'
        expect(page).to have_content 'Factoryで作ったデフォルトのコンテント２'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される                
      end
    end
    #テストで内容を追加 issues#2
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:second_task, name: 'task')
        task = FactoryBot.create(:second_task, name: 'task2')
        visit tasks_path
        task_list= all('.task_list')
        save_and_open_page
        expect(task_list[0]).to have_content 'task2'
        expect(task_list[1]).to have_content 'task'       
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
       end
     end
  end
end