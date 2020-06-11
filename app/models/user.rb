class User < ApplicationRecord
    has_secure :password
    has_many :user_interests
    has_many :interests, through: :user_interests
    has_many :sent_messages, class_name: "Message"
    has_many :received_messages, class_name: "Message", foreign_key: "match_id" 
    has_one :profile

end
