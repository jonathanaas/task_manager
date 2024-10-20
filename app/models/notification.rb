class Notification < ApplicationRecord
    belongs_to :task
    belongs_to :user
    validates :message, presence: true
end
  