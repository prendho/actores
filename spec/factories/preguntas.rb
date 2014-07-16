# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pregunta do
    title "MyString"
    allow_other false
    other_option_id 1
    grupo_pregunta_id 1
    kind 1
    children_ids "MyString"
  end
end
