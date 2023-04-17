class Admin::CustomersController < ApplicationController
  # ログイン済管理者のみにアクセスを許可する
  before_action :authenticate_admin!

  def index #顧客一覧画面
    @customers = Customer.page(params[:page]) #CustomerでCustomerモデルのデータを保持
  end                                         #[.page]メソッドでデータをペジネーションするために使用
                                              #(params[:page])で現在のページ番号を示すために使用されるパラメーター
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報の編集が完了しました。"
      redirect_to admin_cutomer_path(@customer.id) #show(会員詳細)ページへのパス
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :is_deleted)
  end
end