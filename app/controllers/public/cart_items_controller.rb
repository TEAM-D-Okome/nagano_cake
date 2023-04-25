class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total_price = current_customer.cart_items.cart_items_total_price(@cart_items)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if params[:cart_item][:quantity] == "0"
      @cart_item.destroy
      redirect_to cart_items_path
    elsif @cart_item.update(quantity: params[:cart_item][:quantity])
      flash[:notice] = "商品の数量を変更しました。"
      redirect_to cart_items_path
    else
      @cart_items = current_customer.cart_items
      @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_price}
      render "cart_items/index"
    end
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.quantity += params[:cart_item][:quantity].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save!
      flash[:notice] = "商品をカートに追加しました。"
      redirect_to cart_items_path
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :quantity)
  end
end
