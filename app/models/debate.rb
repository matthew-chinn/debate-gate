class Debate < ActiveRecord::Base
  has_many :arguments, dependent: :destroy
  validates :title, presence: true
  validates :description, presence: true

end
