class User < ApplicationRecord
  has_many :categories, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   enum status: {
    buyer: 0,
    moderator: 1
    
  }
end
