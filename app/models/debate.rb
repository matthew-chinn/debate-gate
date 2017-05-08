class Debate < ActiveRecord::Base
  has_many :arguments, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true
  has_and_belongs_to_many :categories, join_table: :category_connector
end
