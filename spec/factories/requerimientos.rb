# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :requerimiento do
    empresa
    sector
    rubro
    consumo 'eventual'
    association :solicitante, :factory => :usuario
  end
end
