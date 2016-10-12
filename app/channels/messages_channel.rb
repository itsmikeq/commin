# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # puts "DATA: #{data.inspect}"
    # stream_from "messages_#{current_user.id}"
    puts "PARAMS: #{params.inspect}"
    if params[:room]
      stream_from "messages:#{params[:room].strip}"
    else
      # No room was selected
      stream_from "messages"
    end
  end

  # TODO: limit connection to rooms by users based on visibility levels and invites
  def create_message(data)
    raise "No room defined - where should the message go?" unless data['room']
    message = Message.new(created_by: current_user.username, body: data['body'], room: data['room'])
    # TODO: Add in @mention and direct the message to a single user in the room via messages:room:username filter
    if message.save
      ActionCable.server.broadcast "messages:#{params[:room]}", message.attributes
    else
      puts message.errors.inspect
      {errors: message.errors}
    end
  end

  # public methods are callable from the client side code
  def like(data)
    puts "Got #{data}"
    # Do some stuff with data here
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

end
