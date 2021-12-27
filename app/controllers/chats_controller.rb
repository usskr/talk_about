class ChatsController < ApplicationController

  def index
    @user = User.where.not(id: current_user.id) && User.offset(rand(User.count)).first
    @currentEntries = current_user.user_rooms
    myRoomIds = []
    @currentEntries.each do |user_room|
      myRoomIds << user_room.room.id
    end
    @anotherEntries = UserRoom.where(room_id: myRoomIds).where('user_id != ?',current_user)
  end

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @room = @chat.room
    if @chat.save
      @roommembernotme = UserRoom.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid = @roommembernotme.find_by(room_id: @room.id)
      notification = current_user.active_notifications.new(
          room_id: @room.id,
          message_id: @chat.id,
          visited_id: @theid.user_id,
          visitor_id: current_user.id,
          action: 'dm'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
          notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  private

    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end
end
