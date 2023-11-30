class PurchaseHistoryAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code,    format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :prefecture_id,  numericality: { other_than: 1,     message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number,   format: { with: /\A\d{10,11}\z/,   message: "is invalid. Input only number"}
    validates :token
  end

  validates :user_id,               presence: { message: 'must exist' }
  validates :item_id,               presence: { message: 'must exist' }


  def save
    purchase_history = PurchaseHistory.create(user_id: user_id, item_id: item_id)
    Address.create(
    postal_code: postal_code, prefecture_id: prefecture_id,
    city: city, address: address, building: building,
    phone_number: phone_number, purchase_history_id: purchase_history.id
    )
  end
end