require 'rails_helper'

RSpec.describe PurchaseHistoryAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    buyer = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user_id: user.id)
    @purchase_history_address = FactoryBot.build(:purchase_history_address, user_id: buyer.id, item_id: item.id)
    sleep 0.01
  end

  describe '購入情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_history_address).to be_valid
      end

      it 'buildingは空でも保存できること' do
        @purchase_history_address.building = ""
        expect(@purchase_history_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_history_address.postal_code = ''
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_history_address.postal_code = '1234567'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'postal_codeが全角数字では保存できないこと' do
        @purchase_history_address.postal_code = '１２３－４５６７'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Postal code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'prefecture_idを選択していないと保存できないこと' do
        @purchase_history_address.prefecture_id = 1
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @purchase_history_address.city = ''
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと保存できないこと' do
        @purchase_history_address.address = ''
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_history_address.phone_number = ''
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できないこと' do
        @purchase_history_address.phone_number = '123456789'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが12桁以上では保存できないこと' do
        @purchase_history_address.phone_number = '123456789012'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが半角のハイフンを含んだ形式では保存できないこと' do
        @purchase_history_address.phone_number = '123-4567-8901'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'phone_numberが半角数字以外では保存できないこと' do
        @purchase_history_address.phone_number = '１２３４５６７８９０'
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_history_address.user_id = nil
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("User must exist")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase_history_address.item_id = nil
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Item must exist")
      end

      it "tokenが空では登録できないこと" do
        @purchase_history_address.token = nil
        @purchase_history_address.valid?
        expect(@purchase_history_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
