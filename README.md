![ロゴ案④](https://user-images.githubusercontent.com/124197100/233823099-3ffbda49-6549-4902-9a04-5b2f4c10ac1e.png)

# Nagano Cakeについて
![スクリーンショット 2023-04-24 123838](https://user-images.githubusercontent.com/124197100/233895043-8f4ea4aa-e4ca-4cf0-ba1a-0c024303fcb9.png)
* [概要](#概要)
* [メンバー](#メンバー)
* [使用している言語フレームワークのバージョン](#使用している言語フレームワークのバージョン)
* [設計書](#設計書)
* [機能](#機能)
* [インストール方法](#インストール方法)
* [管理者ページのログインについて](#管理者ページのログインについて)
* [顧客ページのログインについて](#顧客ページのログインについて)

---

## 概要
長野県にあるケーキ店のECサイト、「ながのcake」のwebアプリケーションです。  
※架空の店舗であり、実際には存在しません。

## メンバー
* がーみ
* ゆか
* あらた

## 使用している言語フレームワークのバージョン
* Ruby 3.1.2
* Rails 6.1.7.3
* bootstrap 4.5

## 設計書
* ER図</br>
![ながのCAKE ER図 drawio (2)](https://user-images.githubusercontent.com/125238969/233823460-5f27089b-42ec-4b5b-9bf6-6009de170942.png)

* テーブル定義書</br>
https://docs.google.com/spreadsheets/d/1qGWpfpw5IadmzRKswRvhe6l5QjI5aYcg3XgwSd3HMGI/edit?usp=sharing

* 詳細設計書</br>
https://docs.google.com/spreadsheets/d/1bt7a7UD8R909atfEBIzOY0F7AfqjyDJnpQdrD_tzZpc/edit?usp=sharing

## 機能
* 顧客側
  * アカウント
    * 新規会員登録
    * ログイン
    * ログアウト
    * 退会（アカウントの論理削除）
    * 会員情報の編集
    * 配達先住所の登録、編集、削除
  * 商品
    * 商品をカートに入れる
    * カート内商品の選択削除、全削除
    * カート内商品の購入
    * 配達先住所の選択
    * 注文履歴の閲覧

* 管理者側
  * 登録ユーザーの一覧表示
  * 登録ユーザーの注文履歴閲覧
  * 商品の新規追加、編集、閲覧
  * 商品情報の編集

* その他
  * 商品の検索機能
    * 商品名での検索
    * ジャンル名での絞り込み

## インストール方法
* 以下のコマンドを上から順に実行してください。
```
git clone git@github.com:TEAM-D-Okome/nagano_cake.git
```

```
cd nagano_cake
```

```
rails db:migrate
```

```
rake db:seed
```

```
yarn install
```

```
bundle install
```
* rails sでサーバーを立ち上げ、ブラウザで閲覧できれば成功です。

## 管理者ページのログインについて
/admin/sign_upをURLに入力し、下記の情報を入力することで管理者としてログインできます。
* メールアドレス: `team_d@okome.com`
* パスワード: `111-111`

## 顧客ページのログインについて
ヘッダーのログインアイコンを押下し、下記の情報を入力することで顧客としてログインできます。
メールアドレスについて、testの後の数字は1~15の任意の数字を入力してください。パスワードは共通です。
* メールアドレス: `test1@gmail.com`
* パスワード: `11111111`
