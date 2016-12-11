# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class WorldMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    puts params.inspect
    puts params[:world_id]
    ActionCable.server.broadcast('messages',
      message: render_message(data['message']))
    message = Message.create(character_id: 1, event_id: 1, message: data['message'])
  end

  def render_message(message)
    ApplicationController.render(
      partial: 'message/message',
      locals: {
        message: message,
        username: current_user
      })
  end
end
