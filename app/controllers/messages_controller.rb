class MessagesController < ApplicationController
  # Probably wont use this - quicker to send and receive on the websocket channel
  before_action :authenticate_user!

  def create
    message = Message.new(message_params)
    if message.save
      ActionCable.server.broadcast 'messages',
                                   body: message.body,
                                   room: message.room
      head :ok
    end
  end

  def message_params
    @message_params ||= params.require(:message).permit(:username, :body, :room)
  end

end
