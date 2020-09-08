# テーブル設計

## users テーブル

| Column          | Type     | Options                    |
| --------------- | -------- | -------------------------- |
| name            | string   | null: false                |
| email           | string   | null: false, unique: true  |
| password        | string   | null: false                |


### Association

- has_many :guests
- has_many :comments

## guests テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| name           | string     | null: false                    |
| gender_id      | integer    | null: false                    |
| addres         | string     | null: false                    |
| visit1_id      | integer    | null: false                    |
| visit2_id      | integer    |                                |
| bathing_id     | integer    | null: false                    |
| drink_id       | integer    | null: false                    |
| warm           | boolean    | default: false, null: false    |
| thickness_id   | integer    | null: false                    |
| description    | text       |                                |
| user           | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| user       | references | null: false, foreign_key: true |
| guests     | references | null: false, foreign_key: true |

### Association

- belongs_to :guests
- belongs_to :users

