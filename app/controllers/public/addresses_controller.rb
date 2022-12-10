class Public::AddressesController < ApplicationController

  before_action :authenticate_customer!

  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:notice] = "配送先の登録が完了しました。"
      redirect_to addresses_path
    else
      flash[:alert] = "再入力をお願いします。"
      @addresses = Address.all
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postcode, :address, :name).merge(customer_id: current_customer.id)
  end

end