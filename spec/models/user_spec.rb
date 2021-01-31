require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '全ての項目を入力すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'メールアドレスが一意であれば登録できる' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email + '_another'
        expect(another_user).to be_valid
      end
      it 'メールアドレスが@を含んでいれば登録できる' do
        @user.email = 'test@sample'
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上かつ、半角英数字混合かつ、確認用の値と同一であれば登録できる' do
        @user.password = 'test00'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'ユーザー本名の名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.lastname = '名字てすとテスト'
        expect(@user).to be_valid
      end
      it 'ユーザー本名の名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.firstname = '名前てすとテスト'
        expect(@user).to be_valid
      end
      it 'ユーザー本名の名字のフリガナが全角カタカナであれば登録できる' do
        @user.lastname_kana = 'ミョウジテスト'
        expect(@user).to be_valid
      end
      it 'ユーザー本名の名前のフリガナが全角カタカナであれば登録できる' do
        @user.firstname_kana = 'ナマエテスト'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'ニックネームが入力されていなければ登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが入力されていなければ登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意でなければ登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスが@を含まなければ登録できない' do
        @user.email.gsub!(/@/, '')
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが入力されていなければ登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードが6文字以上で入力されていなければ登録できない' do
        @user.password = 'a0000'
        @user.password_confirmation = 'a0000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードが半角英数字混合で入力されていなければ登録できない' do
        @user.password = '000000'
        @user.password_confirmation = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが確認用を含めて2回入力されていなければ登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードとパスワード（確認用）の値が一致していなければ登録できない' do
        @user.password = 'a00000'
        @user.password_confirmation = 'b00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ユーザー本名の名字が入力されていなければ登録できない' do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname can't be blank")
      end
      it 'ユーザー本名の名前が入力されていなければ登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
      end
      it 'ユーザー本名の名字が全角（漢字・ひらがな・カタカナ）で入力されていなければ登録できない' do
        @user.lastname = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname には全角文字（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'ユーザー本名の名前が全角（漢字・ひらがな・カタカナ）で入力されていなければ登録できない' do
        @user.firstname = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname には全角文字（漢字・ひらがな・カタカナ）を使用してください')
      end
      it 'ユーザー本名の名字のフリガナが入力されていなければ登録できない' do
        @user.lastname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
      end
      it 'ユーザー本名の名前のフリガナが入力されていなければ登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
      end
      it 'ユーザー本名の名字のフリガナが全角（カタカナ）で入力されていなければ登録できない' do
        @user.lastname_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Lastname kana には全角カタカナを使用してください')
      end
      it 'ユーザー本名の名前のフリガナが全角（カタカナ）で入力されていなければ登録できない' do
        @user.firstname_kana = 'てすと'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname kana には全角カタカナを使用してください')
      end
      it '生年月日が入力されていなければ登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
