class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

 
  
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
