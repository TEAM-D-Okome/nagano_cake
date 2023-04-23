class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new #購入情報の入力画面にて、宛先や住所を入力するところ
    @order = Order.new
    @addresses = current_customer.delivery_addresses.all
    @billing_amount = params[:billing_amount]
  end

  def confirm
     @order = Order.find(params[:id])
    if params[:select_address] == "0"
      @order.address = current_customer.address
      @order.post_code = current_customer.post_code
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:select_address] == "1"
      @delivery_addresses = DeliveryAddress.find(params[:order]["delivery_addresses_id"])
      @order.post_code = @address.post_code
      @order.address = @delivery_addresses.address
      @order.name = @delivery_addresses.name
    elsif params[:select_address] == "2"
    else
      render :new
    end
      @cart_items = current_customer.cart_items.all
  end

  def create
    @customer = current_customer
    @order = current_customer.orders.new(order_params)
    @order.customer_id = @customer.id
    @order.save!

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.order_id = @order.id
      @order_items.item_id = cart_item.item.id
      @order_items.quantity = cart_item.quantity
      @order_items.tax_in_price = cart_item.item.add_tax_tax_out_price
      @order_items.save
    end
      redirect_to confirm_index_path(@order,select_address: params[:order][:select_address])
  end

  def finish
    redirect_to finish_path
    @cart_items = current_customer.cart_items.all
    current_customer.cart_items.destroy_all
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