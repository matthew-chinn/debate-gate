class AddOrderToArguments < ActiveRecord::Migration
  def change
      add_column :arguments, :order, :integer
  end
end
