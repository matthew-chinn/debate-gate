class UserController < ApplicationController
    #before_action :authenticate_user!

    def show
        @user = User.find(params[:id])

        if user_signed_in? and @user.id == current_user.id
            @arguments = Argument.where(creator_id: @user.id)
            @favorites = Array.new
            @user.favorites.each do |fav_id|
                @favorites << Argument.find(fav_id)
            end
        else
            flash[:alert] = "You are not permitted to view that page"
            redirect_to root_path
            return
        end
    end
end 
