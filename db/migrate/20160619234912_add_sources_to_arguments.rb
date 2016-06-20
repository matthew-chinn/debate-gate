class AddSourcesToArguments < ActiveRecord::Migration
  def change
    change_table :arguments do |t|
      t.string :links
    end
  end
end
