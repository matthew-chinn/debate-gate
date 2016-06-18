class AddAssociationsToArguments < ActiveRecord::Migration
  def change
    #Connect an argument to its counter-arguments
    create_table :argument_counters do |t|
      t.integer :argument_id
      t.integer :counter_id
    end

    #Connect an argument to its supporting-arguments
    create_table :argument_supporters do |t|
      t.integer :argument_id
      t.integer :supporter_id
    end

  end
end
