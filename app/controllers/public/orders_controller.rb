class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:address_number] == "0"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name

    elsif  params[:order][:address_number] == "1"
      @addresses = Address.find(params[:order][:address_id])
      @order.postcode = @addresses.postcode
      @order.address = @addresses.address
      @order.name = @addresses.name

    else params[:order][:address_number] == '2'
    end

    @item = current_customer.cart_items
    @total = 0
  end

  def complete
  end

  def create
    @orders = Order.new(order_params)
    @orders.customer_id = current_customer.id
    @orders.save

    current_customer.cart_items.each do |item|
      @item = OrderDetail.new
      @item.item_id = item.item_id
      @item.amount = item.amount
      @item.price = item.item.with_tax_price
      @item.order_id = @orders.id
      @item.making_status = '着手不可'
      @item.save
   end

    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  def index
    @orders = Order.where(customer:current_customer)
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :name, :payment_method, :shipping_cost, :status, :total_payment, :customer_id, :item_id)
  end

end
