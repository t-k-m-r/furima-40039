FactoryBot.define do
  factory :user do
    nickname              { Faker::Lorem.word }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    last_name             { Faker::Name.last_name }
    first_name            { Faker::Name.first_name }
    last_name_kana        { 'カタ' }
    first_name_kana       { 'カナ' }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
