class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,  :username, :email, :image, :age, :city, :gender, :orientation, :ethnicity, :height, :body_shape, :children, :relationship, :education, :bio, :visibility

  attributes :avatar do |object|
    object.avatar
  end

  attributes :interests do |object|
    object.interests
  end
  
end
