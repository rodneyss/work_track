class PagesController < ApplicationController

  def index
   redirect_to login_path if !@current_user

   @user = @current_user

  end
end
