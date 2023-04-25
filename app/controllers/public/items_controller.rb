class Public::ItemsController < ApplicationController
  def index
    @items_all = Item.all
    @genres = Genre.all
    if params[:genre_id]
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.where(is_sale: true).page(params[:page]).per(8).reverse_order
      @items_all = @genre.items.all
    else
      @items = Item.all.where(is_sale: true).page(params[:page]).per(8).reverse_order
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem
  end

  private
  def item_params
    params.require(:items).permit(:genre_id,:name,:explanation,:image,:tax_out_price, :is_sa)
  end

end
