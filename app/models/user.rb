class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :recipes, dependent: :destroy

  validates :username, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, if: -> { new_record? || changes[:password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:password] }
end
