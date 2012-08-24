class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'application'

   #for declarative auth permissions
  filter_resource_access

  #define any other helpers here
  helper_method [:current_user, :readable_role, :layout_prefix]

  private 

	  def layout_prefix
	  	if current_user
		    current_user.active_role
		  else
	    	'application'
	    end
	  end

	  def readable_role
	  	if current_user
		    Role.find_by_name(current_user.active_role).readable_name
		  else
	    	'Guest'
	    end
	  end

  protected

	  #start authlogic methods
	  def current_user_session
	  	return @current_user_session if defined?(@current_user_session)
	  	@current_user_session = UserSession.find
	  end

	  def current_user
	  	return @current_user if defined?(@current_user)
	  	@current_user =  current_user_session && current_user_session.record
	  end

	  def require_user
	    unless current_user
	      flash[:notice] = "You must log in if you want to access that."
	      redirect_to root_url
	      return false
	    end
	  end

	  def require_no_user
	    if current_user
	      #flash[:notice] = "You are already logged in."
	      redirect_to current_user
	      return false
	    end
	  end
	  #end authlogic methods

	  #method for redirecting user if they do not have access via declarative auth
	  def permission_denied
	    flash[:error] = "You do not have access to that."
	    if current_user
	    	redirect_url = user_path(current_user)
	    else 
	    	redirect_url = login_url
	    end
	    respond_to do |format|
	      format.html { redirect_to redirect_url }
	      format.xml { head :unauthorized }
	      format.js { head :unauthorized }
	    end
	  end
end
