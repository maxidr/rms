# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :desglose do
    unidades 10
    precio_unitario "9.99"
    iva "21.0"
    material
  end
end
