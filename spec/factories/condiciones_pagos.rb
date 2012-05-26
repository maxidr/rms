# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :condicion_pago do
    sequence(:nombre) { |n| "Contado #{n}" }
    descripcion "MyString"
  end
end
