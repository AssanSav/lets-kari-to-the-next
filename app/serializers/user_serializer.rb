class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,  :username, :email, :image, :age, :city, :gender, :orientation, :ethnicity, :height, :body_shape, :children, :relationship, :education, :bio

  attributes :avatar do |object|
    object.avatar
  end
end
