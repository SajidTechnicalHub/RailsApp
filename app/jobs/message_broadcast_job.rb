class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chat", { message: render_message(message) }
 
  end


  private

  def render_message(message)
    RatingsController.render(partial: 'message', locals: {message: message}).squish
  end
end
