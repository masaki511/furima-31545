require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @order_address = FactoryBot.build(:order_address)
    end

    it 'すべての情報を適切に入力すると購入できる' do
      expect(@order_address).to be_valid
    end
    it '郵便番号が入力されていなければ購入できない' do
      @order_address.postal_code = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it '郵便番号にハイフンが含まれていなければ購入できない' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code はハイフンを含めて半角数字で入力してください。')
    end
    it '郵便番号が半角数字で入力されていなければ購入できない' do
      @order_address.postal_code = '１２３-４５６７'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code はハイフンを含めて半角数字で入力してください。')
    end
    it '都道府県が選択されていなければ購入できない' do
      @order_address.area_id = 1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Area must be other than 1')
    end
    it '市区町村が入力されていなければ購入できない' do
      @order_address.city = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("City can't be blank")
    end
    it '番地が入力されていなければ購入できない' do
      @order_address.address_line = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Address line can't be blank")
    end
    it '電話番号が入力されていなければ購入できない' do
      @order_address.phone_number = ''
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号が半角数字で入力されていなければ購入できない' do
      @order_address.phone_number = '０９０１２３４５６７８'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number には半角数字を使用してください')
    end
    it 'tokenが空だと購入できない' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
