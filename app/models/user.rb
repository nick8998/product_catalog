class User < ApplicationRecord
  has_many :favorite_products, dependent: :destroy
  has_many :products, through: :favorite_products

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable
end
