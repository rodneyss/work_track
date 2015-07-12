FactoryGirl.define do


  factory :usermake, :class => User do |f|
    f.sequence(:name) {Faker::Name.name}
    f.sequence(:email) {Faker::Internet.email}
    f.sequence(:password) {"password"}
  end





end