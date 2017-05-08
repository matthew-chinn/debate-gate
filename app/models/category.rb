class Category < ActiveRecord::Base
    has_and_belongs_to_many :debates, join_table: :category_connector
end
