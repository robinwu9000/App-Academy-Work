class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many(
    :contacts,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => "ContactShare",
    dependent: :destroy
  )

  has_many(
    :owned_contacts,
    :foreign_key => :user_id,
    :primary_key => :id,
    :class_name => "Contact"
  )

  has_many :shared_contacts, through: :contacts, source: :contact,
      dependent: :destroy
end
