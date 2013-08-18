class ApplicationController < ActionController::Base
  protect_from_forgery

  def login_req
    if(session[:user_id].nil?)
      redirect_to root_url, :notice => "Please Login to Access this page."
    else
      @user = User.find_by_uid(session[:user_id])
    end
  end
end
