class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin! #ログイン済みの管理者のみ権限を与える

  def index #注文履歴一覧
    @orders = Order.page(params[:page]).order(created_at: :desc)
  end

  def show #注文履歴詳細画面(ステータス編集を兼ねる)
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end

  def update #注文ステータス・着手状況の更新
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
    @order.update(order_params)

    if @order.status == Order.statuses.key(1)
      @order_items = OrderItem.where(params[:order_id])
      @order_items.each do |order_item|
        order_item.making_status = OrderItem.making_statuses.key(1)
        order_item.save
      end
    end
      redirect_to request.referer
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end

end