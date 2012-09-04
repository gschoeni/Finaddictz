class RiversController < ApplicationController
  # GET /rivers
  # GET /rivers.json
  def index
    @rivers = River.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rivers }
    end
  end

  # GET /rivers/1
  # GET /rivers/1.json
  def show
    @river = River.find(params[:id])
    @river_json = @river.to_gmaps4rails
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @river }
    end
  end

  # GET /rivers/new
  # GET /rivers/new.json
  def new
    @river = River.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @river }
    end
  end

  # GET /rivers/1/edit
  def edit
    @river = River.find(params[:id])
  end

  # POST /rivers
  # POST /rivers.json
  def create
    @river = River.new(params[:river])

    respond_to do |format|
      if @river.save
        format.html { redirect_to @river, notice: 'River was successfully created.' }
        format.json { render json: @river, status: :created, location: @river }
      else
        format.html { render action: "new" }
        format.json { render json: @river.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rivers/1
  # PUT /rivers/1.json
  def update
    @river = River.find(params[:id])

    respond_to do |format|
      if @river.update_attributes(params[:river])
        format.html { redirect_to @river, notice: 'River was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @river.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rivers/1
  # DELETE /rivers/1.json
  def destroy
    @river = River.find(params[:id])
    @river.destroy

    respond_to do |format|
      format.html { redirect_to rivers_url }
      format.json { head :ok }
    end
  end
end
