# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :proveedor do
    sequence(:razon_social) { |n| "Proveedor #{n}" }
    sequence(:cuit) { |n| "30-1#{n}333444-2" }
  end
end
