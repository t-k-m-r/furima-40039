FactoryBot.define do
  factory :purchase_history_address do
    postal_code   { Faker::Address.postcode }
    prefecture_id { rand(2..48) }
    city          { '東京都' }
    address       { '1-1' }
    building      { '東京ハイツ' }
    phone_number  { Faker::Number.leading_zero_number(digits: 10) }
    token         { 'tok_abcdefghijk00000000000000000' }
  end
end
