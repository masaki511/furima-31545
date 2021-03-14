class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_fee
  belongs_to :area
  belongs_to :necessary_day

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :explanation
    validates :price_before_type_cast,
              format: { with: /\A[0-9]+\z/, message: 'には半角数字を使用してください' },
              numericality: {
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999,
                message: 'は¥300〜¥9,999,999の範囲で設定してください'
              }
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :delivery_fee_id
    validates :area_id
    validates :necessary_day_id
  end
end
