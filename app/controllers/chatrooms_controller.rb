class ChatroomsController < ApplicationController
  def show
    # @chatroom = Chatroom.new
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end
end
