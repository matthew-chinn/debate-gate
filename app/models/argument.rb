class Argument < ActiveRecord::Base
  belongs_to :debate
  validates :title, presence: true
  validates :description, presence: true
  serialize :links

  has_and_belongs_to_many :counter_arguments, class_name: "Argument",
                                              join_table: "argument_counters",
                                              foreign_key: "counter_id"

  has_and_belongs_to_many :supporting_arguments, class_name: "Argument",
                                                 join_table: "argument_supporters",
                                                 foreign_key: "supporter_id"

  def self.pro_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, true)
  end
  
  def self.con_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, false)
  end
end
