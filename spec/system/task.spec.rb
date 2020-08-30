require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    before do
      # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
      visit tasks_path
    end
  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, title: "task")
      FactoryBot.create(:second_task, title:"test")
      FactoryBot.create(:third_task, title: "task3")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'task_name_search', with: 'task'
        # 検索ボタンを押す
        click_on 'Search' 
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        # ここに実装する プルダウンを選択する「select」について調べてみること
        select "未着手", from: "search_status"
        click_on 'Search'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        # ここに実装する
        fill_in 'task_name_search', with: 'task'
        select "未着手", from: "search_status"
        click_on 'Search'
        expect(page).to have_content 'task', "未着手"
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        task = FactoryBot.create(:second_task, name: 'task2')
        task = FactoryBot.create(:third_task, name: 'task3')
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
        task = FactoryBot.create(:task, name: 'task')
        task = FactoryBot.create(:second_task, name: 'task2')
        task = FactoryBot.create(:third_task, name: 'task3')
        visit tasks_path
        task_list= all('.task_list')
        save_and_open_page
        expect(task_list[0]).to have_content 'task3'
        expect(task_list[1]).to have_content 'task2'
        expect(task_list[2]).to have_content 'task'     
      end
    end

    context '終了期限でソートした場合'
      it 'タスクが終了期限順に並んでいる' do
        visit tasks_path
        click_on '終了期限でソートする' 
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'Factoryで作ったデフォルトのタイトル３'
        expect(task_list[1]).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[2]).to have_content 'Factoryで作ったデフォルトのタイトル１'
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