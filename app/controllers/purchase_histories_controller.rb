class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_history_address = PurchaseHistoryAddress.new
    return unless current_user.id == @item.user_id || PurchaseHistory.find_by(item_id: @item.id) != nil

    redirect_to root_path
  end

  def create
    @purchase_history_address = PurchaseHistoryAddress.new(address_params)
    if @purchase_history_address.valid?
      pay_item
      @purchase_history_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:purchase_history_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: address_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find_by(id: params[:item_id])
  end
end
