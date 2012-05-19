# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :usuario do
    nombre "John"
    apellido "Doe"
    sequence(:identificador) { |n| "jdoe_#{n}" }
    rol 'operador'
    password '123456'
    sequence(:email) { |n| "user_#{n}@test.com" }
  end

  factory :admin, :parent => :usuario do
    identificador 'jdoe_admin'
    rol 'administrador'
  end
end
