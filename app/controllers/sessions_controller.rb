class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    @user = User.find_by_uid(auth["uid"]) || User.create_login(auth)
    session[:user_id] = auth["uid"]
    session[:access_token] = auth['credentials']['token']
    redirect_to root_url, :notice => "Signed in!"
  end
  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to root_url
  end
end