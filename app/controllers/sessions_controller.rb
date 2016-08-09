class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
    )

    if @user
      sign_in(@user)
      redirect_to goals_url
    else
      flash[:errors] = 'invalid credentials'
      render :new
    end

  end

  def destroy
    @user = current_user
    sign_out(@user)
    redirect_to new_session_url
  end
end
