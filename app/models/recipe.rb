class Recipe < ApplicationRecord
  belongs_to :user  # ユーザーとの関連付け
  has_many :quantities, dependent: :destroy, inverse_of: :recipe  # 材料（数量）の関連付け
  accepts_nested_attributes_for :quantities, allow_destroy: true  # 材料の追加・削除を許可
  has_many_attached :images  # 複数画像の添付

  # ユーザーが所有するレシピを絞り込むスコープ
  scope :owned_by, ->(user) { where(user: user) }

  before_save :remove_empty_quantities


  # バリデーション
  validates :title, presence: true, length: { maximum: 50 }  # タイトルは必須、最大長は50文字
  validates :description, presence: true  # 説明は必須
  validates :user, presence: true  # ユーザーは必須

  # 画像アップロードに関するバリデーション（必要に応じて）
  validate :validate_image_count

  private

  # 空の材料入力欄を自動削除
  def remove_empty_quantities
    quantities.each do |quantity|
      if quantity.ingredient_name.blank? && quantity.amount.blank?
        quantity.mark_for_destruction
      end
    end
  end

  # 画像の数を検証（例えば、最大5枚まで）
  def validate_image_count
    if images.attached? && images.count > 5
      errors.add(:images, "は最大5枚まで添付できます")
    end
  end
end
