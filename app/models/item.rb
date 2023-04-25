class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items, dependent: :destroy #中間テーブル
  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :explanation, presence: true
  validates :tax_out_price, presence: true
  validates :is_sale, inclusion: [true, false]

  # [tax_out_price]に対して1.10を掛けた値を四捨五入して返す
  # [add_tax]の部分が重要なので消してはいけない[消費税コード]と検索すれば出てくる
  def add_tax_tax_out_price
      (self.tax_out_price * 1.10).round
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/default-image.jpg")
      image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    image.variant(resize: "#{width}x#{height}^", gravity: "center", crop: "#{width}x#{height}+0+0").processed
  end

  def self.search(keyword)
    where(["name like?", "%#{keyword}%"])
  end

end