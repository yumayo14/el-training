[![CircleCI](https://circleci.com/gh/yumayo14/el-training/tree/master.svg?style=svg)](https://circleci.com/gh/yumayo14/el-training/tree/master)

# Small Privete Product Manager(仮)

## アプリケーションの仕様

### 概要
  - 自分１人で行うプログラムの製作で、飽きて辞めてしまうということを防ぐため、製作のために必要なステップと、各ステップの中でどのようなタスクを行うかを明確にするアプリ
 
### コンセプト
  - 最近自分が行なっていること
    - 勉強のために自分身の回りの問題を解決する小さなプログラムを空いている時間に書いている
  - 最近の自分のニーズ・課題
    - 自分の抱えている問題を自分で探すのが結構大変。見つけても、時間が経つと忘れてしまったりする
    - 問題を発見しても、それを解決するプログラムをどうやって実装するかを考えるのが面倒で、実際にプログラミングするところまでいかない。
    - プログラミングに取り掛かっても、途中で飽きて辞めてしまう

### 仮説
  - １人で自分の抱えている問題を解決するために開発を行う際の流れ
    1. 自分が抱えている問題に気づく
    1. その後、どのようなプログラムを作れば解決できそうかを考える
    1. 大まかに、どのようなステップを踏んでプログラムを作るかを考える
    1. 各ステップで、具体的にどのようなタスクをこなすかを考える（並行してプログラミング）

  - なぜ中断するのか
    1. 時間がない
        - 今回考えているアプリ的ではどうしようもないところ。考慮から外す
        - ただ「問題」と「想定する挙動」だけを管理している場合
          - 時間ができた時に思い出して、その後再開する手助けにはなるかも
          - しかし、そういったサービスはすでにある。google keepでよくない？
    2. 飽きる
        - 1: 実装していくと意外と面倒で、終わりが見えなくなってしまう。その結果、やる気が損なわれていく（解決しようとした問題が大きすぎた）
        - 2: やり始めると、あれもこれもとなってしまい、結局どこで終わるかが不明確になってしまう

  - 中断を防ぐ仕組み
    - b: 「飽きる」を防止する方法
      - b-1: アプローチ可能なレベルにまで問題を分解し、実装のために必要なステップを明確にしてあげる
      - b-2:  b-1を行なった上で、各ステップを達成するために必要なことをタスクとして登録できるようにする

### 研修課題の5W1H
- What
  - 「小さいプログラムの製作」を飽きて辞めてしまうということを防ぐため、「製作」のために必要なステップと、各ステップの中でどのようなタスクを行うかを明確にするアプリ
- Why
  - 「何を行えば」製作が終わるかと「後どれくらいで終わりそうか」を可視化できるようにして、途中で飽きてやめるという挫折の仕方を少なくするため
- Who
  - 勉強小さいプログラムを製作しはじめても、途中でつい辞めてしまう初心者エンジニア
- Where
  - 自分の家、お気に入りの作業場所
- When
  - 業務時間外の趣味プログラミングの時
- How
  - 自分の抱える問題を登録できるアプリ。登録した抱える問題に紐づく形で「プログラムを使って実現したい挙動」のドキュメント、いつまでに解決する必要があるかを登録できるようにする。
  
### 具体的な機能
#### 今すでにある機能
  1. 自分の抱えている問題を投稿、編集、削除できる様にする
  1. 自分の抱えている問題を一覧表示できるようにする
  1. 一覧表示された抱えている問題を並び替えられるようにする
  1. 一覧表示された抱えている問題を状態別に絞り込んで表示できる機能
  1. 自分の抱えている問題をいつまでに満たす必要があるかを表示できるようにする

#### 新しく追加したい機能の一覧（1つのPRとして実装できる単位で分割）
  - 自分の抱えている問題に紐づくステップ関連
    - 問題を作る際、ステップが3つ作成されるようにする
    - 各ステップのステップ名と期限を表示する
    - 各ステップを編集できる
    - 3つ以上のステップに分割したい場合、追加でステップが作成できる
    - 必要ないステップがある場合、そのステップを削除できる
    - 各ステップに状態を設定できる（未着手・着手・完了の3つ）
      - 表示の仕方：完了しているステップをどう表示するか、、
    - 問題に紐づいているステップの順番を並び替えられる
      - 表示の仕方：ドラック&ドロップで並び替えられるようにする
    - 矢印のようなもので、あるステップの作業が終わった後、どのステップを行うべきかが明示される
    
  - 各ステップに紐づくタスク関連
    - 各ステップに紐づくタスクを作成できる
    - 各ステップに紐づくタスクを編集できる
      - 表示の仕方：クリックすると表示部分が編集できるようになる形で実装したい
    - 各ステップに紐づくタスクを削除ができる
      - 表示の仕方：hoverしている時のみ、右側に削除アイコンが出て、それを押すと削除されるようにする
    - ステップに紐づいているタスクの順番を並び替えられる
      - 表示の仕方：ドラック&ドロップで並び替えられる
    - タスクの状態を設定できる（完了している or していないの2つ）

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
