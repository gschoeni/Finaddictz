class FishingMethodsController < ApplicationController
  # GET /fishing_methods
  # GET /fishing_methods.json
  def index
    @fishing_methods = FishingMethod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fishing_methods }
    end
  end

  # GET /fishing_methods/1
  # GET /fishing_methods/1.json
  def show
    @fishing_method = FishingMethod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fishing_method }
    end
  end

  # GET /fishing_methods/new
  # GET /fishing_methods/new.json
  def new
    @fishing_method = FishingMethod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fishing_method }
    end
  end

  # GET /fishing_methods/1/edit
  def edit
    @fishing_method = FishingMethod.find(params[:id])
  end

  # POST /fishing_methods
  # POST /fishing_methods.json
  def create
    @fishing_method = FishingMethod.new(params[:fishing_method])

    respond_to do |format|
      if @fishing_method.save
        format.html { redirect_to @fishing_method, notice: 'Fishing method was successfully created.' }
        format.json { render json: @fishing_method, status: :created, location: @fishing_method }
      else
        format.html { render action: "new" }
        format.json { render json: @fishing_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fishing_methods/1
  # PUT /fishing_methods/1.json
  def update
    @fishing_method = FishingMethod.find(params[:id])

    respond_to do |format|
      if @fishing_method.update_attributes(params[:fishing_method])
        format.html { redirect_to @fishing_method, notice: 'Fishing method was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fishing_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fishing_methods/1
  # DELETE /fishing_methods/1.json
  def destroy
    @fishing_method = FishingMethod.find(params[:id])
    @fishing_method.destroy

    respond_to do |format|
      format.html { redirect_to fishing_methods_url }
      format.json { head :ok }
    end
  end
end
