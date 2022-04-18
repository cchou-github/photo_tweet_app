# README

## 初期ユーザー
account: `user_1@phototweet.com`  
password: `@TweetWithOauth2`

## 環境構築
1. Build Docker Image  
`docker-compose build`

2. DB構築  
`docker-compose run --rm rails bundle exec rake db:drop db:create db:migrate db:seed`

3. 環境変数の設置  
`cp .env.example.yml .env.yml`  
.env.ymlの中の環境変数を記入してください

## 時間あればやりたいこと
- idをuuid化
- テストを充実する
- 「ツイートイする」をフロントエンドで非同期
- photoのアクセス権限の向上

## その他
- circleciを使っています
- rspecの部分はgemを使いました
