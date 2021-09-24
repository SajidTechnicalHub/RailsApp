class Category < ApplicationRecord
	belongs_to :user
	has_many :products, dependent: :destroy
	has_one_attached :avatar

	validates :name, presence: true,
                    length: { minimum: 3 }
end
