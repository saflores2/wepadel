class ChatroomsController < ApplicationController
  before_action :skip_authorization
  def create
    @chatroom = Chatroom.new(name: "General")
    if @chatroom.save
      redirect_to chatroom_path(@chatroom.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  # def my_chatrooms
  #   # has many user :trhoug user
  #   @chatroom.users
  #   @chatrooms = Chatroom
  # end
end
