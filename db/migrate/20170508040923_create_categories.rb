class CreateCategories < ActiveRecord::Migration
    def change
        create_table :categories do |t|
            t.string :name
            t.timestamps null: false
        end

        create_table :category_connector do |t|
            t.integer :category_id
            t.integer :debate_id
        end

        add_index :category_connector, :category_id
        add_index :category_connector, :debate_id
    end
end
