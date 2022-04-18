# README

## 初期ユーザー
account: `user_1@phototweet.com`  
password: `@TweetWithOauth2`

## 環境構築
1. Build Docker Image  
`docker-compose build`

2. DB構築  
`docker-compose run --rm rails bundle exec rake db:drop db:create db:migrate db:seed`

3. webpackerでcompile  
`docker-compose run --rm rails rails webpacker:install`

4. 環境変数の記入 
`cp .env.example.yml .env.yml`  
api疎通に必要な情報を.env.ymlの中の環境変数を記入してください

#### Trouble Shooting
OSがwindowsの場合、もし`shebang line ending with \r may cause problems`のようなエラーが出たら、これはwindowsとlinux/macの改行コードが違うからです。  
このrepositoryからcloneしたことをすべて削除した上で下記の順で試してください。

1. `git config --global core.autocrlf input`

2. `git cone https://github.com/cchou-github/photo_tweet_app.git`

原因説明：https://stackoverflow.com/questions/54286602/how-to-fix-shebang-warning-in-ruby  
解決についての説明：https://stackoverflow.com/a/20653073  

```
$ git config --global core.autocrlf false
# Configure Git to ensure line endings in files you checkout are correct for Windows.
# For compatibility, line endings are converted to Unix style when you commit files.
```

## サーバ起動
`docker-compose up`

## 時間あればやりたいこと
- idをuuid化
- 今のテストはrequest specしかないですが、テストをもっと充実したいです
- webpackerの独自のcontainerを作ったほうが良いかもしれません(webpack-dev-server)
- 「ツイートイする」のrequestをフロントエンドで非同期化
- remember meの実装
- photo閲覧権限の見直し

## その他
- circleciを使っています
- rspecの部分はgemを使いました