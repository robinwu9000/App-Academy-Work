require 'securerandom'


class ShortenedUrl < ActiveRecord::Base
  validates :short_url, uniqueness: true, presence: true
  validates :submitter_id, presence: true
  validates :long_url, length: {maximum: 1024}
  validate :user_submission_overflow_or_premium

  belongs_to(
      :submitter,
      foreign_key: :submitter_id,
      primary_key: :id,
      class_name: "User"
  )

  has_many(
    :visits,
    :foreign_key => :short_url_id,
    :primary_key => :id,
    :class_name => "Visit"
  )
  has_many(
    :visitors,
    :through => :visits,
    :source => :user
  )
  has_many(
    :distinct_visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :user
  )

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(:submitter_id => user,
            long_url: long_url,
            :short_url => ShortenedUrl.random_code)
  end

  def self.random_code
    short_url = SecureRandom::urlsafe_base64
    while ShortenedUrl.exists?(:short_url => short_url)
      short_url = SecureRandom::urlsafe_base64
    end
    short_url
  end

  def num_clicks
    visitors.count
  end

  def num_uniques
    distinct_visitors.count
  end

  def num_recent_uniques
    v = Visit.select(:visitor_id).where(:short_url_id => self.id)
    v.where('created_at > ?', 10.minutes.ago).distinct.count
  end

  private

  def user_submission_overflow_or_premium
    unless submitter.premium?
      if ShortenedUrl.where("submitter_id = ? AND created_at > ?",
          submitter_id, 1.minute.ago).count > 5
        errors[:base] << "You submitted too many recently"
      end
    end
  end

end
