[![CircleCI](https://circleci.com/gh/yumayo14/el-training/tree/master.svg?style=svg)](https://circleci.com/gh/yumayo14/el-training/tree/master)

# README

## アプリケーションの仕様

### 概要
 vue.jsを用いたタスク管理アプリケーション
 
### 具体的な機能
- 必須機能
  - 各ユーザーがタスクを投稿、編集、削除できる様にする
  - 自分が投稿したタスクの一覧が見れる様にする
    - 各項目の状態で一覧表示されるタスクを絞り込むことができる様にする
      - 検索関連の機能に関しては非同期で行う様にする。
  
- できたら実装したい機能（どう作成していくかは未定）
  - 現在時刻の天気を外部のAPIを用いて取得し、天気に応じて、天気のアイコン（の様なもの）を切り替える
  - 四季に応じてアプリの背景色を変更できる様にする

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
