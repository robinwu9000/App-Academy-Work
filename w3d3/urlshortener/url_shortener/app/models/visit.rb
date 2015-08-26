class Visit < ActiveRecord::Base
  belongs_to(
    :user,
    :foreign_key => :visitor_id,
    :primary_key => :id,
    :class_name => :User
  )

  belongs_to(
    :shortened_url,
    :foreign_key => :short_url_id,
    :primary_key => :id,
    :class_name => "ShortenedUrl"
  )



  def self.record_visit!(user, shortened_url)
    Visit.create!(:visitor_id => user, :short_url_id => shortened_url)
  end


end
