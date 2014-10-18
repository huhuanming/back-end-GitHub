FactoryGirl.define do
  factory :order do
    ship_type	0
    order_type	0
    phone_number	123123
    shipping_user	"haha"
    shipping_address	"fadfaf我们我们w"
    total_price    "12.233"
    actual_total_price	"12.2"
    food_count 2
  end
end