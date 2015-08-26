# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  visible    :string           not null
#  completed  :boolean          not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :goal do
    title {Faker::Lorem.sentence}
    completed false
    visible {["private", "public"].sample}
    user

    factory :public_goal do
      visible "public"
    end

    factory :private_goal do
      visible "private"
    end
  end
end
