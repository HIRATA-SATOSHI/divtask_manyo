# 「FactoryBotを使用します」という記述
FactoryBot.define do
    # 作成するテストデータの名前を「task」とします
    # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
    factory :task do
      name { 'Factoryで作ったデフォルトのタイトル1' }
      detail { 'Factoryで作ったデフォルトのコンテント1' }
      deadline { DateTime.now }
      status {'completed'}
      priority {'high'}
      association :user
    end
    # 作成するテストデータの名前を「second_task」とします
    # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
    factory :second_task, class: Task do
      name { 'Factoryで作ったデフォルトのタイトル2' }
      detail { 'Factoryで作ったデフォルトのコンテント2' }
      deadline { DateTime.tomorrow }
      status {'not_yet'}
      priority {'middle'}
      association :user
    end

    factory :third_task, class: Task do
      name { 'Factoryで作ったデフォルトのタイトル3' }
      detail { 'Factoryで作ったデフォルトのコンテント3' }
      deadline { DateTime.now.since(5.days) }
      status {'in_progress'}
      priority {'low'}
      association :user
    end    
  end