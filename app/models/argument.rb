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
  before_create :add_order

  def self.pro_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, true)
  end
  
  def self.con_arguments_for(id)
    Argument.where("debate_id = ? AND proponent = ?", id, false)
  end

  def self.within_last_week_for(debate_id)
    Argument.where("debate_id = ? AND updated_at > ?", debate_id, DateTime.now - 7.days)
  end

  def self.arguments_for(debate_id)
    Argument.where(debate_id: debate_id)
  end

  private
  def add_order
      puts "HELLO #{self.debate_id}"
      prev = Argument.where(debate_id: self.debate_id).order("created_at").last.order
      if not prev
          prev = 0
      end
      prev++
      self.order = prev
  end
end
