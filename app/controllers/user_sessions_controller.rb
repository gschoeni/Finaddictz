class UserSessionsController < ApplicationController

  helper_method :current_user
  # GET /user_sessions/new
  # GET /user_sessions/new.json
  def new
    require_no_user
    @user_session = UserSession.new

  end

  # POST /user_sessions
  # POST /user_sessions.json
  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      current_user = UserSession.find.user
      if !current_user.enabled?
        session[:user_enabled] = false
        flash[:error] = "Your account has been temporarily disabled, contact Finaddictz for more details."
        redirect_to logout_url
      else
        flash[:notice] = "Successfully logged in"
        redirect_to current_user
      end
      
    else
      render :action => 'new'
    end
  end


  # DELETE /user_sessions/1
  # DELETE /user_sessions/1.json
  def destroy
    @user_session = UserSession.find
    if @user_session
      @user_session.destroy
    end
    if session[:user_enabled] == false
      session[:user_enabled] = true
      flash[:error] = "Your account has been temporarily disabled, contact Finaddictz for more details."
    else
      flash[:notice] = "Successfully logged out."
    end
    
    redirect_to root_url
  end
end
