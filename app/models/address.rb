class Address < ApplicationRecord
  belongs_to :purchase_history
  belongs_to :prefecture

  validates :postal_code,           presence: true
  validates :prefecture_id,         presence: true, numericality: { other_than: 1, message: "can't be blank" }
  validates :city,                  presence: true
  validates :address,               presence: true
  validates :phone_number,          presence: true
end
