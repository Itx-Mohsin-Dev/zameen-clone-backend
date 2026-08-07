class Property < ApplicationRecord
  belongs_to :user
  has_many :inquiries, dependent: :destroy
  has_many :inquired_users, through: :inquiries, source: :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :property_images, dependent: :destroy

  enum :property_type, { house: 0, apartment: 1, plot: 2, commercial: 3 }
  enum :purpose, { sale: 0, rent: 1 }
  enum :status, { pending: 0, approved: 1, rejected: 2 }
  enum :marla_type, { marla_225: 0, marla_272: 1 }

  validates :title, presence: true
  validates :description, presence: true
  validates :location, presence: true
  validates :city, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :area, presence: true, numericality: { greater_than: 0 }
  validates :bedrooms, numericality: { only_integer: true, greater_than: 0 }
  validates :bathrooms, numericality: { only_integer: true, greater_than: 0 }
  validates :property_type, presence: true
  validates :purpose, presence: true
  validates :status, presence: true
  validates :marla_type, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[
      purpose
      city
      location
      property_type
      price
      area
      bedrooms
      bathrooms
      title
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
