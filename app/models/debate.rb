class Debate < ActiveRecord::Base
  has_many :arguments
  validates :title, presence: true
  validates :description, presence: true

end
