class ChatroomsController < ApplicationController
  before_action :skip_authorization
  def create
    @chatroom = Chatroom.new()
    @chatroom.tournament_id = params[:tournament_id]
    @chatroom.user_id = @chatroom.tournament.user_id
    @chatroom.name = @chatroom.tournament.name
    redirect_to chatroom_path(@chatroom.id) if @chatroom.save
  end

  def my_chatrooms
    @chatrooms = Chatroom.where(user_id: current_user.id)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end
end
