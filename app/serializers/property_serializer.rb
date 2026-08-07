class PropertySerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :location, :city, :price, :area, :property_type, :bathrooms, :bedrooms, :purpose, :user_id, :is_favorited, :favorite_id, :marla_type, :latitude, :longitude
  belongs_to :user
  has_many :property_images

  def is_favorited
    return false unless scope

    scope.favorites.exists?(property_id: object.id)
  end

  def favorite_id
    return nil unless scope

    favorite = scope.favorites.find_by(property_id: object.id)
    favorite&.id
  end
end
