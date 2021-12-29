class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :room, optional: true
  belongs_to :chat, optional: true

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
