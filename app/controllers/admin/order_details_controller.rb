class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = Orderdetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order = @order_detail.order

    redirect_to request.referer

    #order_detailモデルの製作ステータスが制作中になると
    if @order_detail.making_status == "制作中"
      #orderモデルの注文ステータスが制作中に更新される
      @order.update(status: 2)
      @order.save
    end

    # 注文商品の個数 == 注文商品のどこの？（製作ステータス: 製作完了）になってる個数が同じなら
    if  @order.order_details.count == @order.order_details.where(making_status: 3).count
      # orderモデルの注文ステータスが発送準備中に更新される
      @order.update(status: 3)
      @order.save
    end

  end

  private

  def ordered_good_params
    params.require(:order_detail).permit(:order_id, :making_status, :amount, :item_id)
  end

end
