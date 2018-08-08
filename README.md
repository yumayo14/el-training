# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
 2.5.1

* Rails version
 5.2.0
* System dependencies

* Configuration

* Database creation
 Mysql2  (heroku上でもMysql2を用いる)
 version 0.5.2
* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

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
