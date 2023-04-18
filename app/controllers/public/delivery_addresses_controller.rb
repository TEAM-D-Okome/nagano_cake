class Public::DeliveryAddressesController < ApplicationController
  def index
    @customer = current_user
    @delivery_addresses = @customer.delivery_addresses
    @new_delivery_address = DeliveryAddress.new
  end

  def create
    @delivery_addresses = DeliveryAddress.new(delivery_addresses_params)
    @delivery_addresses.customer_id = current_user.id
    if @delivery_addresses.save
      redirect_to delivery_addresses_path
    else
      @customer = current_user
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
      redirect_to delivery_addresses_path
    else
      render :edit
    end
  end

  def destroy
    delivery_addresses = DeliveryAddress.find(params[:id])
    delivery_addresses.destroy
    redirect_to delivery_addresses_path
  end

  private
  def delivery_addresses_params
    params.require(:delivery_addresses).permit(:post_code, :address, :name)
  end
end
