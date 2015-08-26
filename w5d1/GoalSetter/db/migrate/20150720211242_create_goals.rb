class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :visible, null: false
      t.boolean :completed, null: false
      t.references :user, index:true

      t.timestamps null: false
    end
  end
end
