class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :location, :city, :price, :area, :property_type, :bathrooms, :bedrooms, :purpose, :user_id
  belongs_to :user
  has_many :property_images
end
