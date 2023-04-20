# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'team_d@okome.com',
  password: '111-111'
)

15.times do |n|
    Customer.create!(
      email: "test#{n + 1}@gmail.com",
      password: "11111111",
      last_name: "山田",
      first_name: "太郎",
      last_name_kana: "ヤマダ",
      first_name_kana: "タロウ",
      post_code: "9518553",
      address: "新潟市中央区西堀通6番町866番地",
      phone_number: "00000000000"
    )
  end


gente_lists = ["ケーキ", "焼き菓子", "ドーナツ", "チョコレート", "キャンディ", "マカロン"]
for i in gente_lists do
  Genre.create!(
    name: i
  )
end