class CreateArguments < ActiveRecord::Migration
  def change
    create_table :arguments do |t|

      t.timestamps null: false
    end
  end
end
