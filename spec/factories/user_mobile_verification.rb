FactoryGirl.define do
  factory :user_mobile_verification do
    verification_code "123456"
    phone_number "12345678910"
  end
end