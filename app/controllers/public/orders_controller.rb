class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  #データを入力し送る→データを保存せずにそのまま表示→次の画面でデータ保存の流れ

  def new #注文情報入力
    @order = Order.new
    @addresses = current_customer.delivery_addresses.all #住所を(0)[自分の住所](1)[登録済住所](2)[新しいお届け先]から選択する
  end                                                     #注文情報入力画面 new.html.erbで条件を分けてformを送り、def confirmで設定をし直す

  def confirm #注文情報確認
     @total_item_price = 0 #合計金額の初期化
     @order = Order.new(order_params) # @orderは大きな箱で、その中に小さい箱を指定するためにストロングパラメーターを指定している
    if params[:order][:select_address] == "0" #newにある[:select_address] == "0"のデータ(ご自身の住所)を呼び出す
      @order.address = current_customer.address #ordersのカラム
      @order.post_code = current_customer.post_code #ordersのカラム
      @order.name = "#{current_customer.last_name + current_customer.first_name}" #ordersのカラム
    elsif params[:order][:select_address] == "1" #newにある[:select_address] == "1"のデータ(登録済み住所)を呼び出す
      @addresses = DeliveryAddress.find(params[:order]["customer_id"]) #ordersのcustomer_id(=カラム)で登録先の住所を選び、そのデータ送る
      @order.post_code = @addresses.post_code
      @order.address = @addresses.address
      @order.name = @addresses.name
    elsif params[:order][:select_address] == "2" #newにある[:select_address] == "2"のデータ(新しいお届け先)を呼び出す
      @order.post_code = params[:order]["post_code"]
      @order.address = params[:order]["address"]
      @order.name = params[:order]["name"]
    else
      render :new #情報入力に失敗した時はnew.html.erbから動かない
    end
      @cart_items = current_customer.cart_items.all #カート商品をconfirm(注文確認画面)で表示させる
  end

  def create #注文情報保存
    @customer = current_customer
    @cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    @order.save

    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_items = OrderItem.new #初期化宣言
      @order_items.order_id = @order.id
      @order_items.item_id = cart_item.item.id
      @order_items.quantity = cart_item.quantity
      @order_items.tax_in_price = cart_item.item.add_tax_tax_out_price
      @order_items.save
    end
      redirect_to complete_orders_path #注文完了ページに遷移
      current_customer.cart_items.destroy_all #カートの中身を削除
  end

  def complete #注文完了
  end

  def index
    @orders = current_customer.orders.page(params[:page]).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items
  end

  private

  def order_params                    #送料,支払方法,請求金額,郵便番号,住所,宛名,注文ステータス,顧客ID
    params.require(:order).permit(:postage,:pay_method,:billing_amount,:post_code,:address,:name,:status,:customer_id)
  end

end