class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_day
  has_one_attached :image

  validates :image,              presence: true
  validates :name,               presence: true
  validates :info,               presence: true
  validates :category_id,        presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id,       presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_charge_id, presence: true, numericality: { other_than: 1 , message: "status can't be blank"}
  validates :prefecture_id,      presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :delivery_day_id,    presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price,              presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

end
