class Poll < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to(
    :author,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => "User"
  )

  has_many(
    :questions,
    :foreign_key => :poll_id,
    :primary_key => :id,
    :class_name => "Question"
  )
end
