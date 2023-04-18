class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.where(is_sale: true)
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_sale: true).page(params[:page]).reverse_order
    else
      @items = Item.where(is_sale: true).page(params[:page]).reverse_order
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.where(is_sale: true)
    @cart_item = CartItem.new
  end
end
