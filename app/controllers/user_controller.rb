class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @arguments = Argument.where(creator_id: @user.id)
    @favorites = Array.new
    @user.favorites.each do |fav_id|
        @favorites << Argument.find(fav_id)
    end
  end
end 
