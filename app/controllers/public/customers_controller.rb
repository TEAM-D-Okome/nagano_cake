class Public::CustomersController < ApplicationController
  def show
    @customer = Customers.find(current_user.id)
  end

  def edit
    @customer = Customers.find(current_user.id)
  end

  def update
    @customer = Customers.find(current_user.id)
    if @customer.update(customer_params)
      redirect_to customer_path(current_user.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = Customers.find(current_user.id)
  end

  def withdrawal
    @customer = Customers.find(current_user.id)
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :phone_number)
  end
end
