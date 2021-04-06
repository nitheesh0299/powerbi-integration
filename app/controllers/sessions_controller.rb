class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:company_id] = user.companyid
      session[:role] = user.role
      puts session[:email_id]
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:company_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
