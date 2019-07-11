[![CircleCI](https://circleci.com/gh/yumayo14/el-training/tree/master.svg?style=svg)](https://circleci.com/gh/yumayo14/el-training/tree/master)

# Small Privete Product Manager(仮)

## アプリケーションの仕様

### 概要
  - プライベートで、自分の小さなニーズや要求を満たすプログラムを製作する際、ニーズとプログラムが想定する挙動を紐づけて管理できるようにするアプリ
 
### コンセプト
  - 自分が誰よりもヘビーユーザーになれるアプリ
    - 最近自分が行なっていること
      - 勉強のために自分身の回りの問題を解決する小さなプログラムを空いている時間に書いている
    - 最近の自分のニーズ・課題
      - 自分の抱えている問題を自分で探すのが結構大変。見つけても、時間が経つと忘れてしまったりする
      - 問題を発見しても、それを解決するプログラムをどうやって実装するかを考えるのが面倒で、実際にプログラミングするところまでいかない。
      - 明確な期限を定めずになぁなぁになってしまう

### 研修課題の5W1H
- Who
  - 勉強で小さいプログラムを製作したいけど、中々作り始められない新人エンジニア
- What
  - プライベートで、自分の抱えている問題を解決するプログラムを製作する際、自分のニーズとプログラムが想定する挙動を紐づけて管理できるようにするアプリ
- Why
  - 抱えている問題にふと気づいて、作りたいなぁと思っても実際に作り始めるところまでいかないといったことを無くすため
  - プログラミング初級者にとって、自分で「プログラムで実現したい挙動」を考えるという作業は大変だから
- Where
  - 自分の家、お気に入りの作業場所
- When
  - 業務時間外の趣味プログラミングの時
- How
  - 自分の抱える問題を登録できるアプリ。登録したニーズに紐づく形で「プログラムを使って実現したい挙動」のドキュメント、いつまでに解決する必要があるかを登録できるようにする。
  
### 具体的な機能
- 必須機能
  - 自分の抱えている問題を投稿、編集、削除できる様にする
  - 自分の抱えている問題を一覧表示できるようにする
  - 一覧表示された抱えている問題を並び替えられるようにする
  - 一覧表示された抱えている問題を状態別に絞り込んで表示できる機能
  - 自分の抱えている問題をいつまでに満たす必要があるかを表示できるようにする
  - 自分の抱えている問題に紐づく形で、「プログラムを使って実現したい挙動」をドキュメントとして作成できるようにする
  - 作成した、「プログラムを使って実現したい挙動」ドキュメントを見れるようにする

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
