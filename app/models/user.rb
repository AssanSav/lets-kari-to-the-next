class User < ApplicationRecord
    has_secure_password
    has_many :user_interests
    has_many :interests, through: :user_interests
    has_many :sent_messages, class_name: "Message"
    has_many :received_messages, class_name: "Message", foreign_key: "match_id" 

    validates_presence_of :username, :email, :image, :age, :city, :gender, :orientation, :ethnicity, :height, :body_shape, :children, :relationship, :education, :bio
    validates_uniqueness_of :email, :username
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

    before_create :set_default_avatar

    def set_default_avatar
        if self.image == ""
        self.image = "https://cdn1.iconfinder.com/data/icons/ninja-things-1/1772/ninja-simple-512.png"
        end
    end

  def find_my_matches 
    users = User.joins(:user_interests).where('user_interests.interest_id IN (?)', self.interest_ids).where.not(id: self.id)
    if self.orientation == "Straight"
      matches = users.select do |user|
        user.gender != self.gender && self.orientation == user.orientation
      end
      matches.uniq
    elsif self.orientation == "Lesbian" || self.orientation == "Gay"
      matches = users.select do |user|
        user.gender == self.gender && self.orientation == user.orientation
      end
      matches.uniq
    end
  end

end
