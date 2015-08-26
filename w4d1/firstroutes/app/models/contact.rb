class Contact < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :user_id, presence: true, :uniqueness => {:scope => :email}

  belongs_to(
    :owner,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User
  )

  has_many(
    :contacts,
    :foreign_key => :contact_id,
    :primary_key => :id,
    :class_name => "ContactShare"
  )

  has_many :shared_users, through: :contacts, source: :user
end
