class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true, uniqueness: true
  serialize :favorites

  def toggle_favorite( arg_id )
      if self.favorites != nil and self.favorites.include? arg_id
          self.favorites.delete arg_id
          ret = false
      else
          self.favorites = Array.new
          self.favorites << arg_id
          ret = true
      end
      self.save
      return ret
  end

  def on_favorite( arg_id )
      if self.favorites == nil
          self.favorites = Array.new
      end

      if not self.favorites.include? arg_id
          self.favorites << arg_id
          self.save
      end
  end
end
