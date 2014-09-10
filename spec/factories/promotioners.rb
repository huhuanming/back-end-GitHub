FactoryGirl.define do
  factory :promotioner, class: Promotioner do
  	phone_number "1212"
    encrypted_password "$2a$10$1g1TVWOQAZmDDVCM37N5DeZTy79A.K6uscv23MSngO9nlpEmzr5TO"
    nick_name "admin@example.com"
    reset_password_token "admin@example.com"
    reset_password_sent_at "2014-08-14 05:30:57"
    remember_created_at "2014-08-14 05:30:57"
    sign_in_count 0
    current_sign_in_at "admin@example.com"
    current_sign_in_ip "admin@example.com"
    last_sign_in_ip "admin@example.com"
    confirmed_at "2014-08-14 05:30:57"
    confirmation_sent_at "2014-08-14 05:30:57"
    failed_attempts 0
    unlock_token "admin@example.com"
    locked_at "2014-08-14 05:30:57"
    zone_id 0

    trait :promotioner_with_login do
      phone_number "1212"
      encrypted_password "$2a$10$1g1TVWOQAZmDDVCM37N5DeZTy79A.K6uscv23MSngO9nlpEmzr5TO"
      nick_name "1212"
      sign_in_count 0
      failed_attempts 0
      zone_id 0
    end

    trait :promotioner_with_access_token do
      phone_number "1212"
      encrypted_password "$2a$10$1g1TVWOQAZmDDVCM37N5DeZTy79A.K6uscv23MSngO9nlpEmzr5TO"
      nick_name "1212"
      sign_in_count 0
      failed_attempts 0
      zone_id 0
    end
  end
end