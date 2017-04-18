class UserController < ApplicationController
    #before_action :authenticate_user!

    def show
        @user = User.find(params[:id])

        if user_signed_in? and @user.id == current_user.id
            @arguments = Argument.where(creator_id: @user.id)
            @favorites = @user.favorites.map{ |f| Argument.find(f.argument_id) }
        else
            flash[:alert] = "You are not permitted to view that page"
            redirect_to root_path
            return
        end
    end
end 
