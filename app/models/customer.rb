class Customer < ApplicationRecord
  has_many :delivery_addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # Deviseが提供する認証機能を有効にするために必要なメソッド
  # database_authenticatableは、ユーザーがパスワードを入力して認証するための機能
  # registerableは、ユーザーがアカウントを作成できるようにする機能
  # recoverableは、ユーザーがパスワードをリセットできるようにする機能
  # rememberableは、ユーザーのログイン情報を覚えておく機能
  # validatableは、ユーザーが入力した情報が正しいかどうかを検証する機能
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :post_code, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
end
