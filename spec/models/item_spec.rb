require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('public/image/output-image.jpeg')
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての情報を入力すると登録できる' do
        expect(@item).to be_valid
      end
    end
    context '出品できないとき' do
      it '出品画像が選択されていなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が入力されていなければ出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品の説明が入力されていなければ出品できない' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end
      it 'カテゴリーが選択されていなければ出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it '商品の状態が選択されていなければ出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it '配送料の負担が選択されていなければ出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
      end
      it '発送元の地域が選択されていなければ出品できない' do
        @item.area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Area must be other than 1')
      end
      it '発送までの日数が選択されていなければ出品できない' do
        @item.necessary_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Necessary day must be other than 1')
      end
      it '価格が入力されていなければ出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price before type cast can't be blank")
      end
      it '価格が半角数字で入力されていなければ出品できない' do
        @item.price = '９９９９'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast には半角数字を使用してください')
      end
      it '価格が¥299以下の場合は出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast は¥300〜¥9,999,999の範囲で設定してください')
      end
      it '価格が¥10,000,000以上の場合は出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price before type cast は¥300〜¥9,999,999の範囲で設定してください')
      end
    end
  end
end
