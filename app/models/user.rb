class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :email, uniqueness: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'には英字と数字の両方を含めて設定してください' }
  with_options presence: true do
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'には全角文字（漢字・ひらがな・カタカナ）を使用してください' } do
      validates :lastname
      validates :firstname
    end
    with_options format: { with: /\A[ァ-ヶ]+\z/, message: 'には全角カタカナを使用してください' } do
      validates :lastname_kana
      validates :firstname_kana
    end
    validates :nickname
    validates :birthday
  end
end
