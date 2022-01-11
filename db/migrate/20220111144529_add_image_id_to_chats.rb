class AddImageIdToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :image_id, :string
  end
end
