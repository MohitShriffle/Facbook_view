class UserSerializer < ActiveModel::Serializer
  attributes :id ,:first_name ,:last_name,:password  
  # has_many :posts
  # def image 
  #   object.profile_picture.url
  # end
end
