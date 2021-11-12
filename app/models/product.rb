class Product < ApplicationRecord
  paginates_per 12
  belongs_to :user
  belongs_to :category
  has_many :order_items
  has_many :ratings
  has_one_attached :avatar



  validates :name, presence: true,
                    length: { minimum: 3 }
  validates :price, :desc, :avatar, presence: true
end
