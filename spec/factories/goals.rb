FactoryGirl.define do
  factory :goal do
    goal_text "MyText"
    user_id 1
    visibility "MyString"
    completed false
  end
end
