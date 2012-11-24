class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find_by_email(params[:session][:email])

    if user && user.authenticate(params[:session][:password])
      #
      # user is in the database and the password for this
      # user authenticates:
      sign_in user
      #
      # redirect_back if originally trying to access a protected page.
      redirect_back_or user
      #
    else
      # Something is afoul, not quite right
      #
         # Note: flash persist for one request but re-rendering with render
         #       does not count as a request. The result would be that the
         #       flash message will appear on the next page requested.
         #       flash.now[:error] instead of flash[:error] will resolve this.
      #
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
      #
    end
      
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
