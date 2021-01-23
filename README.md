## usersテーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| lastname           | string  | null: false               |
| firstname          | string  | null: false               |
| lastname_kana      | string  | null: false               |
| firstname_kana     | string  | null: false               |
| nickname           | string  | null: false               |
| birthday           | date    | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |

### Association

- has_many :items
- has_many :orders

## itemsテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| explanation    | text       | null: false                    |
| category       | string     | null: false                    |
| condition      | string     | null: false                    |
| delivery-fee   | string     | null: false                    |
| area           | string     | null: false                    |
| necessary-days | integer    | null: false                    |
| price          | integer    | null: false                    |
| user_id        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| card_number  | string     | null: false                    |
| card_year    | integer    | null: false                    |
| card_month   | integer    | null: false                    |
| card_code    | integer    | null: false                    |
| postal-code  | string     | null: false                    |
| prefecture   | string     | null: false                    |
| city         | string     | null: false                    |
| address-line | string     | null: false                    |
| phone-number | integer    | null: false                    |
| user_id      | references | null: false, foreign_key: true |
| item_id      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item