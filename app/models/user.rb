class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, uniqueness: true
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/.freeze
  validates :lastname, presence: true, format: { with: NAME_REGEX, message: 'には全角文字（漢字・ひらがな・カタカナ）を使用してください' }
  validates :firstname, presence: true, format: { with: NAME_REGEX, message: 'には全角文字（漢字・ひらがな・カタカナ）を使用してください' }
  NAME_KANA_REGEX = /\A[ァ-ヶ]+\z/.freeze
  validates :lastname_kana, presence: true, format: { with: NAME_KANA_REGEX, message: 'には全角カタカナを使用してください' }
  validates :firstname_kana, presence: true, format: { with: NAME_KANA_REGEX, message: 'には全角カタカナを使用してください' }
  validates :nickname, presence: true
  validates :birthday, presence: true
end
