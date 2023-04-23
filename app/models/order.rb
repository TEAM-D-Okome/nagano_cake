class Order < ApplicationRecord
  belongs_to :customer
  has_many :items, through: :order_items #注文には商品が多くある
  has_many :order_items, dependent: :destroy #中間テーブル

  # enum(列拳型)で検索すれば使用方法が出てくる
  enum pay_method: { credit_card:0, transfer:1 }
  # 0=入金待ち、1=入金確認、2=製作中、3=発送準備中、4=発送済み
  enum status: { waiting:0, confirm:1, making:2, preparation:3, sent:4 }

  validates :post_code, presence: true
  validates :address, presence: true
  validates :name, presence: true

end
