class Public::ItemsController < ApplicationController
  
  def index
    @total_items = Item.all
    @items = Item.page(params[:page]).reverse_order
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
    @cart_item = CartItem.new
  end
  
end
