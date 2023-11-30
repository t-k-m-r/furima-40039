class PurchaseHistoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchase_history_address = PurchaseHistoryAddress.new
    @item = Item.find_by(id: params[:item_id])
    if current_user.id == @item.user_id || PurchaseHistory.find_by(item_id: @item.id) != nil
      redirect_to root_path
    end
  end

  def create
    @purchase_history_address = PurchaseHistoryAddress.new(address_params)
    if @purchase_history_address.valid?
      @purchase_history_address.save
      redirect_to root_path
    else
      @item = Item.find_by(id: params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:purchase_history_address).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
