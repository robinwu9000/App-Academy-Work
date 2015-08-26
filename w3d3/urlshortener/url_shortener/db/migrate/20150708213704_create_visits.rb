class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.integer :short_url_id
      t.timestamps null: false
    end
    add_foreign_key :visits, :users, column: :visitor_id
    add_foreign_key :visits, :shortened_urls, column: :short_url_id
  end
end
