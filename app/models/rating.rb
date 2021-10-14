class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :product

  # after_create_commit { 
  #   ActionCable.server.broadcast "chat", { 
  #     message: MessagesController.render(
  #       partial: 'message', 
  #       locals: { message: message }
  #     ).squish 
  #   }
  # }
  
  after_create_commit { MessageBroadcastJob.perform_later(self) }
end
