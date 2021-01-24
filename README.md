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

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| name             | string     | null: false                    |
| explanation      | text       | null: false                    |
| category_id      | integer    | null: false                    |
| condition_id     | integer    | null: false                    |
| delivery-fee_id  | integer    | null: false                    |
| area_id          | integer    | null: false                    |
| necessary-day_id | integer    | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order

## ordersテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal-code  | string     | null: false                    |
| area_id      | integer    | null: false                    |
| city         | string     | null: false                    |
| address-line | string     | null: false                    |
| phone-number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order