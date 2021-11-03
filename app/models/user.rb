class User < ApplicationRecord
  has_many :categories, :dependent => :destroy
  has_many :products, :dependent => :destroy
  has_many :ratings, :dependent => :destroy
  has_many :orders, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar


  def avatar_thumbnail
    if avatar.attached?
      #avatar.variant(resize: '150*150!').processed
    else
      '/default_profile.jpeg'
   end
  end


   enum status: {
    buyer: 0,
    moderator: 1
    
  }


private
  
  

end
