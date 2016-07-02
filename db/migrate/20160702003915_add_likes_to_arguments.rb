class AddLikesToArguments < ActiveRecord::Migration
  def change
    change_table :arguments do |t|
      t.integer :likes
      t.integer :dislikes
    end
  end
end
