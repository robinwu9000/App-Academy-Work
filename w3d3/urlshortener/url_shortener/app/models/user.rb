class User < ActiveRecord::Base
  validates :email, :uniqueness => true, :presence => true
  before_save { |user| user.email.downcase! }
  has_many(:submitted_urls,
           :foreign_key => :submitter_id,
           :primary_key => :id,
           :class_name => "ShortenedUrl"
    )

    has_many(
      :visits,
      :foreign_key => :visitor_id,
      :primary_key => :id,
      :class_name => "Visit"
    )
    has_many :visited_urls, :through => :visits, :source => :shortened_url

    has_many(
      :distinct_visited_urls,
      -> { distinct },
      :through => :visits,
      :source => :shortened_url
    )

    def distinct_url_count
      distinct_visited_urls.count
    end
end
