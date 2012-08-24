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
      flash[:notice] = "Successfully logged in"
      #not quite sure why it wants object id here... can usually just say user_path(current_user)
      current_user = UserSession.find.user
      id = current_user.id
      puts "Current user id: #{id}"
      redirect_to current_user
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

    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
