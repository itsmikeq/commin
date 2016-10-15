# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    unless params[:room]
      raise StandardError.new("Missing Room!")
    end
    stream_from queue, -> (message) do
      # TODO: Do some ability checking here
      transmit ActiveSupport::JSON.decode(message), via: queue
    end
  end

  # TODO: limit connection to rooms by users based on visibility levels and invites
  def create_message(data)
    raise ArgumentError.new("No room defined - where should the message go?") unless data['room']
    message = Message.new(created_by: current_user.username, body: clean_body(data['body']), room: data['room'])
    # TODO: Add in @mention and direct the message to a single user in the room via messages:room:username filter
    if message.save
      ActionCable.server.broadcast queue, message.attributes
    else
      Rails.logger.error message.errors.inspect
      {errors: message.errors}
    end
  end

  # public methods are callable from the client side code
  def like(data)
    puts "Got #{data}"
    # Do some stuff with data here, like broadcast it
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # TODO: Create a background job to:
    # TODO: Capture image and video context
    # TODO: Remove messages as they are ephemeral
  end

  def clean_body(_body)
    # TODO: Make this a background job
    # _body.gsub(/\n/, '<br>')
    _body
  end

  def queue
    @queue = "messages:#{params[:room].strip}"
  end

  def room
    @room ||= begin
      Room.find_by(name: params[:room].strip).first || Room.find_or_create_by(name: params[:room].strip, created_by: current_user.username)
    end
  end

end
