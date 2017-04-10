class CreateFavorites < ActiveRecord::Migration
    def change
        #remove serialized values, do favorites table instead
        remove_column :users, :favorites
        remove_column :arguments, :favoritors

        create_table :favorites do |t|
            t.integer :user_id
            t.integer :argument_id
        end
    end
end
