[![CircleCI](https://circleci.com/gh/yumayo14/el-training/tree/master.svg?style=svg)](https://circleci.com/gh/yumayo14/el-training/tree/master)

# Small Privete Project Manager(仮)

## アプリケーションの仕様

### 概要
  - プライベートで小さなプログラムを製作する際に使える、タスク管理アプリ。発想ベースのものを、具体的なタスクに落としこめるようにするもの。
 
### コンセプト
  - 自分が誰よりもヘビーユーザーになれるアプリ
    - 最近自分が行なっていること
      - 勉強のために自分身の回りの問題を解決する小さなプログラムを空いている時間に書いている
    - 最近の自分のニーズ
      - 思いついたはいいけど、具体的にどうやって実装するかを考えるのが面倒でやらなくなってしまう
      - 明確な期限を定めずになぁなぁになってしまう
      - 実装に取り掛かったはいいが、意外と面倒で触らなくなって、気づいたらやめてしまう

### ユーザーがどう使うかの5W1H
- Who
  - 勉強で小さいプログラムを製作したいエンジニア
- What
  - プライベートで小さなプログラムを製作する際に使える、タスク管理アプリ。発想ベースのものを、具体的なタスクに落としこめるようにするもの。
- Why
  - 発想まで出たのはいいけど、実際に作り始めるところまでいかないといったことを無くすため
  - 見積もりに失敗した際、具体的なドキュメントとしてその情報を残せるようにしておけるため
- Where
  - 自分の家、お気に入りの作業場所
- When
  - 業務時間外の趣味プログラミングの時
- How
  - 発想したものを登録。登録したアイデアに紐づく形で仕様書、期限を設定できるようにする。
  
### 具体的な機能
- 必須機能
  - 小さいプログラムのアイデアを投稿、編集、削除できる様にする
  - 小さいプログラムのアイデアを一覧表示できるようにする
  - 小さいプログラムのアイデアを状態別に絞り込んで表示できる機能
  - 小さいプログラムのアイデアを表示する際、いつまでに終えるべきかも表示されるようにする
  - 小さいプログラムのアイデアに紐づく形で、実現したい挙動のドキュメントを作成できるようにする
  - 作成した、実現したい挙動のドキュメントを見れるようにする
 

## 開発環境

* Ruby version
  - 2.5.5

* Rails version
  - 5.2.3
* System dependencies

* Configuration

* Database creation
  - Mysql2 version 0.5.2

## テーブル図

###Taskテーブル

|   column   |    type     |   option     |
|:-----------|------------:|:------------:|
| title      | string      | null: false  |
| importance | integer     |              |
|dead_line_on| date        | null: false  |
| status     | integer     | default: 0   |
| detail     | text        |              |
| user       | references  |              |

date型 _onで終わるから無名
datetime型  _atで

###Userテーブル

|   column   |    type     |   option     |
|:-----------|------------:|:------------:|
| name       | string      | null: false  |
| email      | string      | null: false  |
| password   | string      | null: false  |

###Labelテーブル

|   column   |    type     |   option     |
|:-----------|------------:|:------------:|
| name       | string      | null: false  |
|tagged_count| integer     |              |

###TaskLabelテーブル

|   column   |    type     |   option     |
|:-----------|------------:|:------------:|
| task       | references  |              |
| label      | references  |              |


------------------------------------------------------------------------------------------------------------------------------

herokuへのデプロイ

0. herokuアカウントでherokuにログイン
 - heroku login

1. heroku上のアプリにローカルの変更を反映
 - git push heroku master
 - DBに変更がある場合は、heroku run rake db:migrate

2. herokuアプリを開く方法
 - heroku open
