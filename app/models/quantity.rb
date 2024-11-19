class Quantity < ApplicationRecord
  belongs_to :recipe  # レシピとの関連付け
  validates :ingredient_name, presence: true
  validates :amount, presence: true
end
