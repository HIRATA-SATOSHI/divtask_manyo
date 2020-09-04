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
end