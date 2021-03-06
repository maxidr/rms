# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :moneda do
    sequence(:simbolo) { |n| "simbolo #{n}" }
    nombre "Pesos"
  end

  factory :pesos, class: Moneda do
    simbolo '$'
    nombre 'Pesos'
  end
end
