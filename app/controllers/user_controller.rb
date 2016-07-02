class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @arguments = Argument.where(creator_id: @user.id)
  end
end
