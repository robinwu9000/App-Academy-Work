class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :long_url, :null => false
      t.text :short_url, null: false
      t.integer :submitter_id

      t.timestamps null: false
    end
    add_index(:shortened_urls, :submitter_id)
    add_index(:shortened_urls, :short_url)
  end
end
