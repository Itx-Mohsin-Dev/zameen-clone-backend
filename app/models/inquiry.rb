class Inquiry < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true
end
