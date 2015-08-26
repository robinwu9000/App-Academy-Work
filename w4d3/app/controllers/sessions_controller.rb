class SessionsController < ApplicationController
  before_action :already_signed_in, except: :destroy

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user.nil?
      render :new
    else
      login!(@user)
      unless Session.user_has_session?(@user.session_token, @user.id)
        Session.create!(session_token: @user.session_token, user_id: @user.id)
      end
      redirect_to cats_url
    end
  end

  def destroy
    @user = User.find_by_session_token(session[:session_token])
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

end
