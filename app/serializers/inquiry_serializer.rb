class InquirySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :property_id, :name, :email, :message, :created_at
  belongs_to :property
end
