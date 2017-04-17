class CreateSources < ActiveRecord::Migration
    def change
        remove_column :arguments, :links
        create_table :sources do |t|
            t.integer :argument_id
            t.string :url

            t.timestamps null: false
        end
    end
end
