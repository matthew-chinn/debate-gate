class CreateDebates < ActiveRecord::Migration
  def change
    create_table :debates do |t|
      t.string :title 
      t.string :description
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
