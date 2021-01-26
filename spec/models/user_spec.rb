require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスは、@を含む必要があること' do
      @user.email.gsub!(/@/, '')
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = 'a0000'
      @user.password_confirmation = 'a0000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = '000000'
      @user.password_confirmation = '000000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
    end
    it 'パスワードは、確認用を含めて2回入力すること' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'パスワードとパスワード（確認用）、値の一致が必須であること' do
      @user.password = 'a00000'
      @user.password_confirmation = 'b00000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'ユーザー本名の名字が必須であること' do
      @user.lastname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname can't be blank")
    end
    it 'ユーザー本名の名前が必須であること' do
      @user.firstname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname can't be blank")
    end
    it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.lastname = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Lastname には全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end
    it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.firstname = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include('Firstname には全角文字（漢字・ひらがな・カタカナ）を使用してください')
    end
    it 'ユーザー本名の名字のフリガナが必須であること' do
      @user.lastname_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
    end
    it 'ユーザー本名の名前のフリガナが必須であること' do
      @user.firstname_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
    end
    it 'ユーザー本名の名字のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.lastname_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include('Lastname kana には全角カタカナを使用してください')
    end
    it 'ユーザー本名の名前のフリガナは、全角（カタカナ）での入力が必須であること' do
      @user.firstname_kana = 'てすと'
      @user.valid?
      expect(@user.errors.full_messages).to include('Firstname kana には全角カタカナを使用してください')
    end
    it '生年月日が必須であること' do
      @user.birthday = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
