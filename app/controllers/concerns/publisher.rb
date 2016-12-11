module Publisher
  extend ActiveSupport::Concern

  # In order to publish message we need a exchange name.
  # Note that RabbitMQ does not care about the payload -
  # we will be using JSON-encoded strings
  def self.publish(name, message = {})
    # grab the fanout exchange
    x = channel.fanout(name)
    # and simply publish message
    x.publish(message.to_json)
  end

  def self.channel
    @channel ||= connection.create_channel
  end

  # We are using default settings here
  # The `Bunny.new(...)` is a place to
  # put any specific RabbitMQ settings
  # like host or port
  def self.connection
    @connection ||= Bunny.new.tap do |c|
      c.start
    end
  end

  def self.fetch_queue(name)
    x = channel.fanout(name)
  end
end
