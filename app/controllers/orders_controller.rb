class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total = current_cart.total_price

    if @order.save
      current_cart.cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order = @order
        order_detail.product_name = cart_item.product.title
        order_detail.product_price = cart_item.product.price
        order_detail.quantity = cart_item.quantity
        order_detail.save
      end
      redirect_to order_path(@order.token)
    else
      render 'carts/checkout'
    end
  end

  def show
    @order = Order.find_by_token(params[:id])
    @order_details = @order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address)
  end
end
