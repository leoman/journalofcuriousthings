include ActionDispatch::TestProcess

product = {
  title: "My first product",
  subtitle: 'An amazing subtitle',
  description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
  status: :live,
  product_type: :print,
  sticky: true,
  date: Date.today,
  price_currency: 'GBP',
  price_cents: '1050'
}

FactoryBot.define do

  factory :product do
    sequence(:title) { |n| "My #{n} product" }
    subtitle { product[:subtitle] }
    description { product[:description] }
    status { product[:status] }
    product_type { product[:product_type] }
    date { product[:date] }
    price_currency { product[:price_currency] }
    price_cents { product[:price_cents] }
    mainImage { fixture_file_upload("#{Rails.root}/spec/files/post-1.jpg")  }

    trait :product_type_class do
      product_type { :class }
    end

    trait :product_type_print do
      product_type { :print }
    end
  end

end