class Public::DeliveryAddressesController < ApplicationController
  def index
    @new_delivery_address = DeliveryAddress.new
    @customer = current_customer
    @delivery_addresses = @customer.delivery_addresses
  end

  def create
    @delivery_addresses = DeliveryAddress.new(delivery_addresses_params)
    @delivery_addresses.customer_id = current_customer.id
    if @delivery_addresses.save
      redirect_to delivery_addresses_path, notice: "住所の登録に成功しました。"
    else
      @customer = current_customer
      @delivery_addresses = @customer.delivery_addresses
      render :index
    end
  end

  def edit
    @delivery_addresses = DeliveryAddress.find(params[:id])
  end

  def update
    @delivery_addresses = DeliveryAddress.find(params[:id])
    if @delivery_addresses.update(delivery_addresses_params)
      redirect_to delivery_addresses_path, notice: "編集に成功しました。"
    else
      render :edit
    end
  end

  def destroy
    delivery_addresses = DeliveryAddress.find(params[:id])
    delivery_addresses.customer_id = current_customer.id
    delivery_addresses.destroy
    redirect_to delivery_addresses_path, notice: "住所を削除しました。"
  end

  private
  def delivery_addresses_params
    params.require(:delivery_address).permit(:post_code, :address, :name)
  end
end
