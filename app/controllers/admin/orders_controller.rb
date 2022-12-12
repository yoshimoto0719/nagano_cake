class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    # [:order][:status]→orderの中のstatus
    if params[:order][:status] == "入金確認"
      # making_statusを製作待ちに更新
      @order.order_details.update(making_status: 1)
    end

    redirect_to request.referer

  end

  private

  def order_params
    params.require(:order).permit(:status, :making_status)
  end

end
