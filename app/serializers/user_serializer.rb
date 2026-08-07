class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :phone,
             :cnic,
             :role,
             :profile_image
end