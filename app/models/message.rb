class Message < ApplicationRecord
    belongs_to :user
    belongs_to :match, class_name: "User"

    validates_presence_of :content
end
