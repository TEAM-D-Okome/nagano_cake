class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin! # ログイン済管理者のみにアクセスを許可する

  def index #顧客一覧
    @customers = Customer.page(params[:page]) #CustomerでCustomerモデルのデータを保持
  end                                         #[.page]メソッドでデータをペジネーションするために使用
                                              #(params[:page])で現在のページ番号を示すために使用されるパラメーター
  def show #顧客詳細
    @customer = Customer.find(params[:id])
  end

  def edit #顧客情報編集
    @customer = Customer.find(params[:id])
  end

  def update #顧客情報更新
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報の編集が完了しました。"
      redirect_to admin_customer_path(@customer.id) #編集成功時はshow(会員詳細)へ遷移
    else
      render :edit #編集に失敗した場合は編集画面へ遷移
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number, :is_deleted,:email)
  end
end