class AddSourcesToArguments < ActiveRecord::Migration
  def change
    change_table :arguments do |t|
      t.string :links, array: true
    end
    add_index :arguments, :links, using: 'gin'
  end
end
