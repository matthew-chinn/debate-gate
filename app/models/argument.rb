class Argument < ActiveRecord::Base
  belongs_to :debate
  validates :title, presence: true
  validates :description, presence: true

  def self.pro_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, true)
  end
  
  def self.con_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, false)
  end
end
