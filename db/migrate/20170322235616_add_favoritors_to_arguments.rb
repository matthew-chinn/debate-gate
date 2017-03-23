class AddFavoritorsToArguments < ActiveRecord::Migration
  def change
      add_column :arguments, :favoritors, :string
  end
end
