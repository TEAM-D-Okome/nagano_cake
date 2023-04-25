class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin! #ログイン済みの管理者のみに権限を与える

  def index #商品一覧
    @items = Item.page(params[:page]) #Item.page(params[:page])は現在のページ番号を表す
  end                                 #ペジネーションされた状態の情報を[@items]に格納する

  def new #商品新規登録表示
    @item = Item.new
  end

  def create #商品情報新規登録
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を新規登録しました。"
      redirect_to admin_item_path(@item) #商品詳細showへ遷移
    else
      render :new #失敗時は新規登録画面へ遷移
    end
  end

  def show #商品詳細
    @item = Item.find(params[:id])
  end

  def edit #商品編集
    @item = Item.find(params[:id])
  end

  def update #商品情報更新
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を更新しました。"
      redirect_to admin_item_path(@item) #商品詳細showへ遷移
    else
      render :edit #失敗時は商品編集画面へ遷移
    end
  end

  private

  def item_params             #商品画像、商品名、商品説明、ジャンル、税抜価格、販売ステータス
    params.require(:item).permit(:image,:name,:explanation,:genre_id,:tax_out_price,:is_sale)
  end

end
