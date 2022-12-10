class Public::CustomersController < ApplicationController

  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customers_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, alert: "退会しました"
  end

  private

  def customers_params
    params.require(:customer).permit(
      :first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phone_number, :email)
  end
end
