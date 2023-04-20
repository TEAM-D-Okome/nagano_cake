class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def subtotal
    item.add_tax_tax_out_price * quantity
  end

  def self.cart_items_total_price(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.item.tax_out_price * cart_item.quantity
    end
    return (array.sum * 1.1).floor
  end
end