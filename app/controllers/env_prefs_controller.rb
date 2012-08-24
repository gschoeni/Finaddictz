class EnvPrefsController < ApplicationController
  # GET /env_prefs
  # GET /env_prefs.json
  def index
    @env_prefs = EnvPref.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @env_prefs }
    end
  end

  # GET /env_prefs/1
  # GET /env_prefs/1.json
  def show
    @env_pref = EnvPref.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @env_pref }
    end
  end

  # GET /env_prefs/new
  # GET /env_prefs/new.json
  def new
    @env_pref = EnvPref.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @env_pref }
    end
  end

  # GET /env_prefs/1/edit
  def edit
    @env_pref = EnvPref.find(params[:id])
  end

  # POST /env_prefs
  # POST /env_prefs.json
  def create
    @env_pref = EnvPref.new(params[:env_pref])

    respond_to do |format|
      if @env_pref.save
        format.html { redirect_to @env_pref, notice: 'Env pref was successfully created.' }
        format.json { render json: @env_pref, status: :created, location: @env_pref }
      else
        format.html { render action: "new" }
        format.json { render json: @env_pref.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /env_prefs/1
  # PUT /env_prefs/1.json
  def update
    @env_pref = EnvPref.find(params[:id])

    respond_to do |format|
      if @env_pref.update_attributes(params[:env_pref])
        format.html { redirect_to @env_pref, notice: 'Env pref was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @env_pref.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /env_prefs/1
  # DELETE /env_prefs/1.json
  def destroy
    @env_pref = EnvPref.find(params[:id])
    @env_pref.destroy

    respond_to do |format|
      format.html { redirect_to env_prefs_url }
      format.json { head :ok }
    end
  end
end
