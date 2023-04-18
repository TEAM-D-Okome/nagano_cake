class Admin::OrderItemsController < ApplicationController
    before_action :authenticate_admin! #ログイン済みの管理者のみ権限を与える

  def update #製作ステータスの更新
    @order_item = OrderItem.find(params[:id]) #注文商品の中から(params[:id]) で指定さえれたものを検索
    @order = @order_item.order #order_itemに関連するorder(belongs_toで関連づいた)オブジェクトを取得、
    @order_items = @order.order_items.all #@orderに関連する全てのOrderItemオブジェクトを取得
    @order_item.update(item_params) #ストロングパラメーターを使用して@order_itemの属性を更新
                                    #具体的には、item_paramsで指定された属性を使用して、@order_itemのデータベースレコードを更新

    #注文商品の製作ステータスが1つ以上"製作中"の時、注文ステータスを"製作中"に変更
    if @order_items.where(making_status: 2).count >= 1
      @order.status = 2
      @order.save
    end

    #注文商品の製作ステータスが全て"製作完了"の時、注文ステータスを"発送準備"に変更
    if @order_items.where(making_status: 3).count == @order_items.count
      @order.status = 3
      @order.save
    end
    redirect_to request.referer #元の画面へ遷移
  end

  private

  def item_params
    params.require(:order_item).permit(:making_status)
  end

end