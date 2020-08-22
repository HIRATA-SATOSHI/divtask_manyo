# USER テーブル

|カラム|データ型|
|:--:|:--:|
|name|string|
|email|string|
|password_dogest|string|

# task テーブル
|カラム|データ型|
|:--:|:--:|
|name|string|
|detail|text|

# label テーブル
|カラム|データ型|
|:--:|:--:|
|name|string|

# labelingsテーブル
|カラム|データ型|
|:--:|:--:|
|task_id|integer|
|label_id|integer|


# Herokuへのデプロイ手順
___
## コミットをする
___
git commit -m "コミットメッセージ例"
___
## Herokuに新しいアプリケーションを作成
$ heroku create　を行う
URLは毎回異なる
___
## Heroku buildpackを追加
Heroku buildpackとは、作成したアプリケーションをHeroku上でコンパイルするためのもの.
基本的には、Herokuがソースコードの開発言語に合わせて自動検出し、buildpackがインストールされます。しかし、それだけでは不十分な場合や追加でbuildpackが必要な場合には、
次のようにコマンドを実行してbuildpackを追加できます。
- $ heroku buildpacks:set heroku/ruby
- $ heroku buildpacks:add --index 1 heroku/nodejs
___
## Herokuへデプロイ
 $ git push heroku master
___

## データベースへの移行
Herokuデータベースの作成は自動で行われますが、マイグレーション（テーブル作成）は手動で実行する必要があります。
$ heroku run rails db:migrate

## アプリケーションにアクセスする
Herokuアプリのアドレスは https://アプリ名.herokuapp.com/ のように設定される
アクセスする。