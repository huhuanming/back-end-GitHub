FactoryGirl.define do
  factory :supervisor do
    restaurant_id 2
    phone_number "1212"
    encrypted_password "$2a$10$1g1TVWOQAZmDDVCM37N5DeZTy79A.K6uscv23MSngO9nlpEmzr5TO"
    nick_name "1212"
    sign_in_count 0
    failed_attempts 0
    trait :supervisor_with_login do
      nick_name   "John Doe"
    end


    trait :second_supervisor do
      nick_name "John Snow"
      phone_number "1313"
      encrypted_password "$2a$10$1g1TVWOQAZmDDVCM37N5DeZTy79A.K6uscv23MSngO9nlpEmzr5TO"
    end
  end
end