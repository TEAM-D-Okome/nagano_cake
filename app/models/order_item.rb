class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  # 0=着手不可、1=製作待ち、2=制作中、3=製作完了
  enum making_status: { not_make: 0, wait_make: 1, now_make: 2, complete_make: 3}

  # [sum_praice]という名のメソッドで、[add_tax_out_price]という属性の値に消費税を加算する
  # [add_tax_out_price]には消費税を含まない値が想定されている
  # [quantity]をという属性の値をかけることで、注文数に応じた合計金額を計算する
  def sum_price
    add_tax_out_price * quantity
  end
end
