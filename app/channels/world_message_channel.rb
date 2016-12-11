# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
import "pry"
class WorldMessageChannel < ApplicationCable::Channel
  def subscribed
    template = 'messages_%s'
    channel = template % [params[:world_id]]
    stream_from channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    template = 'messages_%s'
    channel = template % [data['world_id']]
    puts channel
    ActionCable.server.broadcast(channel,
      message: render_message(data['message']))
    message = Message.create(character_id: data['character_id'],
      event_id: data['event_id'], message: data['message'])
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
