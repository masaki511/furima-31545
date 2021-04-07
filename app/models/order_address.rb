class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :city, :address_line, :building_name, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを含めて半角数字で入力してください。' }
    validates :city
    validates :address_line
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'には半角数字を使用してください' },
                             length: { maximum: 11, message: 'は11桁以内で入力してください。' }
    validates :token
  end
  validates :area_id, numericality: { other_than: 1 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, address_line: address_line,
                   building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end
