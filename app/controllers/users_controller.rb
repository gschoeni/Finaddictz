class UsersController < ApplicationController
 

  # GET /users
  # GET /users.json
  def index
    @users  = User.fullSearch(params)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @my_posts = @user.my_posts
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    @user.roles << Role.find_by_name("angler")
    @user.active_role = "angler"
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        format.html { redirect_to login_path, notice: 'Check your email for to confirm your account.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Successfully updated profile' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  #for after a user signs up, they must confirm by following a link from their email
  # /users/confirm/1/af33afbbd58fa9f093793ff4cc99f51a9ee6c6bd
  def confirm 
    user = User.find(params[:id])
    if(user.confirmed?) 
      redirect_to login_path, notice: "You've already confirmed your account. Please log in to continue."
    else
      #ex) greg.schoeninger@gmail.com = af33afbbd58fa9f093793ff4cc99f51a9ee6c6bd
      hashed_email = Digest::SHA1.hexdigest(user.email)
      if hashed_email == params[:sha]
        user.confirmed = true
        user.save
        redirect_to login_path, notice: "Thank you, your account has been confirmed. Please log in to continue."
      else 
        redirect_to login_path, notice: "You are not allowed to perform this action"
      end
    end
  end


  #for changing a users role
  def change_role
    require_user
    role = params[:role]

    #check if the user has this role before switching roles
    valid_role = false
    current_user.roles.each{|r| 
      valid_role = true if r.name == role 
    }
    if valid_role
      current_user.active_role = role
      if current_user.save
        flash[:success] = "You have switched to #{role}"
        redirect_to current_user
      else 
        flash[:error] = "Looks like there was a problem switching roles.."
        redirect_to current_user
      end
    else 
      redirect_to current_user, notice: "You are not allowed to perform this action"
    end

  end

  def toggle_enabled
    require_user #makes sure we have a current user, declarative auth should check if the user is admin

    user = User.find(params[:id])

    #toggle enabled
    if user.disabled?
      user.enable = true
    else
      user.enable = false
    end

    #save and redirect
    if user.save
      enabled_string = (user.disabled? && 'disabled') || 'enabled'
      flash[:success] = "User: #{user} has been #{enabled_string}"
      redirect_to users_path
    else 
      flash[:error] = "There was a problem saving the user.. Gotta look into it"
      redirect_to users_path
    end
  end

end
