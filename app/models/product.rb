class Product < ApplicationRecord
  has_many :favorite_products, dependent: :destroy

  validates :title, :description, :image_url, presence: true

  scope :order_by_update, -> { order(updated_at: :asc) }
  # I dont sure that this is right, cause I know "Id is unique". But I dont understand how do this from the TR
  scope :order_by_hand, -> { order(hand: :asc) }
end
