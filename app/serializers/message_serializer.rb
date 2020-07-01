class MessageSerializer
  include FastJsonapi::ObjectSerializer
  attributes :content, :created_at, :user_id, :match_id, :id

  attributes :sender_name do |object|
    object.user.username
  end

  attributes :match_name do |object|
    object.match.username
  end

  attributes :image do |object|
    object.user.image
  end
end
