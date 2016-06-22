class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      render 'home'
    else
      #render 'index'
      redirect_to new_user_session_path
    end
  end
end
