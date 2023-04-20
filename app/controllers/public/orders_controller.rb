class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #購入情報の入力画面にて、宛先や住所を入力するところ
    @order = Order.new
    @delivery_addresses = current_customer.delivery_addresses.all
  end

  def create
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.order_id = order.id
      @order_items.item_id = cart_item.item.id
      @order_item.quantity = cart_item.quantity
      @order_items.tax_in_price = cart_item.item.add_tax_tax_out_price
      @order_items.making_status = 0
      @order_items.save!
    end
    CartItem.destroy_all
    redirect_to orders_completed_path
  end

  def confirm
     @billing_amount = 0
     @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
       @address = Address.find(params[:order][:address_id])
       @order.post_code = @address.post_code
       @order.address = @address.address
       @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.cus_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :confirm
  end

  def complete
  end

  def index
    @orders = current_customer.orders.page(params[:page]).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: params[:id])
  end

  private

  def order_params                    #送料,支払方法,請求金額,郵便番号,住所,宛名,注文ステータス
    params.require(:order).permit(:postage,:pay_method,:billing_amount,:post_code,:address,:name,:status,:customer_id)
  end

  def cart_item_nill
     cart_items = current_customer.cart_items
     if cart_items.blank?
      redirect_to cart_items_path
     end
  end

end