class Public::HomesController < ApplicationController
  def top
    @items = Item.where(is_sale: true).reverse_order
    @genres = Genre.all
  end

  def about
  end
end
