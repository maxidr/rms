# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sector do
    sequence(:nombre) { |n| "sector #{n}" }
    responsables { FactoryGirl.create_list(:usuario, 1) }
  end

end
