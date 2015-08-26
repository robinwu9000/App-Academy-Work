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

class Goal < ActiveRecord::Base
  validates :title, :visible, :user, presence: true
  validates :completed, inclusion: { in: [true, false] }
  belongs_to :user
  after_initialize :default_noncomplete

  def default_noncomplete
    self.completed = false if new_record?
    save!
  end
end
