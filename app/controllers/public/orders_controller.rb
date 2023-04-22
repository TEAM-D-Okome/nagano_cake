class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #購入情報の入力画面にて、宛先や住所を入力するところ
    @order = Order.new
    @delivery_addresses = current_customer.delivery_addresses.all
  end

  def confirm
     @billing_amount = 0
     @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @delivery_addresses = DeliveryAddress.find(params[:order]["delivery_addresses_id"])
      @order.post_code = @address.post_code
      @order.address = @delivery_addresses.address
      @order.name = @delivery_addresses.name
    elsif params[:order][:select_address] == "2"
      @order.post_code = params[:order]["post_code"]
      @order.address = params[:order]["address"]
      @order.name = params[:order]["name"]
    else
      render :new
    end
      @cart_items = current_customer.cart_items.all
  end

  def create
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.order_id = @order.id
      @order_items.item_id = cart_item.item.id
      @order_item.quantity = cart_item.quantity
      @order_items.tax_in_price = cart_item.item.add_tax_tax_out_price
      @order_items.save
    end
      redirect_to finish_order_path
      current_customer.cart_items.destroy_all
  end

  def complete
  end

  def index
    @orders = current_customer.orders.page(params[:page]).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params                    #送料,支払方法,請求金額,郵便番号,住所,宛名,注文ステータス
    params.require(:order).permit(:postage,:pay_method,:billing_amount,:post_code,:address,:name,:status)
  end

end