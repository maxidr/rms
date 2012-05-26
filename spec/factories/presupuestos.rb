# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :presupuesto do
    moneda
    condicion_pago
    proveedor
    desgloses { FactoryGirl.create_list(:desglose, 1) }
  end
end
