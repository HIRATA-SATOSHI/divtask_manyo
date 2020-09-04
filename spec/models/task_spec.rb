require 'rails_helper'
describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(name: '', detail: '失敗テスト')
        expect(task).not_to be_valid
      end
  end
  
  context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        # ここに内容を記載する
        task = Task.new(name: '詳細がからのテスト', detail: '')
        expect(task).not_to be_valid
      end
    end
    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = FactoryBot.create(:task, name: 'task', detail: 'detail')
        # task = Task.new(name: "hogehoge", detail: "gehogeho")
        # binding.pry
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    # 必要に応じて、テストデータの内容を変更して構わない
    # let!(:task) = FactoryBot.create(:task, name: 'task')
    # let!(:second_task) = FactoryBot.create(:second_task, name: "sample")
    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        # name_seachはscopeで提示したタイトル検索用メソッドである。メソッド名は任意で構わない。
        expect(Task.name_search('task')).to include(task)
        expect(Task.name_search('task')).not_to include(second_task)
        expect(Task.name_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに内容を記載する
        select "未着手", from: "task_status"
        click_on 'Search'
        expect(page).to have_content '未着手'        
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        select "未着手", from: "task_status"
        click_on 'Search'
        expect(page).to have_content '未着手'
      end
    end
  end

end