class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_items_index, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :area_id, :city, :address_line, :building_name, :phone_number).merge(
      user_id: current_user.id, token: params[:token], item_id: params[:item_id]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_items_index
    redirect_to root_path if (current_user.id == @item.user_id) || !@item.order.nil?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
    )
  end
end
