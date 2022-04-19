# README

## 初期ユーザー
account: `user_1@phototweet.com`  
password: `@TweetWithOauth2`

## 環境構築
1. Build Docker Image  
`docker-compose build`

2. DB構築&&初期データを投入  
`docker-compose run --rm rails bundle exec rake db:drop db:create db:migrate db:seed`

3. webpackerをinstall  
`docker-compose run --rm rails rails webpacker:install`

4. 環境変数の記入  
`cp .env.example.yml .env.yml`  
api疎通に必要な情報を`.env.yml`の中の環境変数を記入してください

## サーバ起動
1. `docker-compose up`
2. `http://localhost:3000/`でログイン画面へアクセスする

## Trouble Shooting
環境構築またはサーバ起動の時OSがwindowsの場合、もし`shebang line ending with \r may cause problems`のようなエラーが出たら、これはwindowsとlinux/macの改行コードが違うからです。  
widnowsはCRLF(\r\n)、 linux/macはLF(\n)。  
このrepositoryからcloneしたものをすべて削除した上で下記の順でもう一度試してください。

1. `git config --global core.autocrlf input`
コマンド説明：https://stackoverflow.com/a/20653073  
このrepositoryの改行コードがLFですのでから、cloneしたソースコードをCRLFへ変換しないようにする。  
またwindowsからpushしたソースコードを  

2. `git clone https://github.com/cchou-github/photo_tweet_app.git`

3. `[1. Build Docker Image]`から`[4. 環境変数の記入]`までもう一度試してください

原因説明：https://stackoverflow.com/questions/54286602/how-to-fix-shebang-warning-in-ruby  

## 時間あればやりたいこと
- idをuuid化
- 今のテストはrequest specしかないですが、テストをもっと充実したいです
- webpackerの独自のcontainerを作ったほうが良いかもしれません(webpack-dev-server)
- 「ツイートイする」のrequestをフロントエンドで非同期化
- remember meの実装
- 画像urlにのファイル名が含まないようにする
- photo閲覧権限の見直し

## その他
- circleciを使っています
- rspecの部分はgemを使いました