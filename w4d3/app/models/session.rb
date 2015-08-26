class Session < ActiveRecord::Base
  validates :user_id, :session_token, presence: true
  validates :session_token, uniqueness: {scope: :user_id}

  belongs_to :user, :foreign_key => :session_token

  def self.user_has_session?(session_token, user_id)
    session = Session.find_by(session_token: session_token)
    session.user_id == user_id
  end



end
