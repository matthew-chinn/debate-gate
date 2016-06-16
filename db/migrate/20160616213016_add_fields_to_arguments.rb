class AddFieldsToArguments < ActiveRecord::Migration
  def change
    change_table :arguments do |t|
      t.string :title
      t.integer :creator_id
      t.boolean :proponent
      t.string :description
      t.integer :debate_id
    end
  end
end
