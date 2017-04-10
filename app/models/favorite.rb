class Favorite < ActiveRecord::Base
    belongs_to :user
    belongs_to :argument

    #return true if created a new favorite, else false
    def self.toggle( user_id, arg_id )
        f = Favorite.find_by( user_id: user_id, argument_id: arg_id )
        if f
            f.delete
            return false
        else
            Favorite.create(user_id: user_id, argument_id: arg_id)
            return true
        end
    end
end
