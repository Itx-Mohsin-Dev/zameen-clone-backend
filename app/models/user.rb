class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  has_many :properties, dependent: :destroy
  has_many :inquiries, dependent: :destroy
  has_many :inquired_properties, through: :inquiries, source: :property
  has_many :favorites, dependent: :destroy
  has_many :favorited_properties, through: :favorites, source: :property

  enum :role, { buyer: 0, seller: 1, admin: 2 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, presence: true
  validates :role, presence: true
end
