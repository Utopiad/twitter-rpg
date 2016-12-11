module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :current_world, :current_event, :character

    def connect
      self.current_user = cookies.signed[:current_user_id]
      self.current_world = cookies.signed[:current_world_id]
      self.current_event = cookies.signed[:current_event_id]
      self.character = cookies.signed[:character_id]
    end
  end
end
