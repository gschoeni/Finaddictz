class FishSpeciesController < ApplicationController
  # GET /fish_species
  # GET /fish_species.json
  def index
    @fish_species = FishSpecy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fish_species }
    end
  end

  # GET /fish_species/1
  # GET /fish_species/1.json
  def show
    @fish_specy = FishSpecy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fish_specy }
    end
  end

  # GET /fish_species/new
  # GET /fish_species/new.json
  def new
    @fish_specy = FishSpecy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fish_specy }
    end
  end

  # GET /fish_species/1/edit
  def edit
    @fish_specy = FishSpecy.find(params[:id])
  end

  # POST /fish_species
  # POST /fish_species.json
  def create
    @fish_specy = FishSpecy.new(params[:fish_specy])

    respond_to do |format|
      if @fish_specy.save
        format.html { redirect_to @fish_specy, notice: 'Fish specy was successfully created.' }
        format.json { render json: @fish_specy, status: :created, location: @fish_specy }
      else
        format.html { render action: "new" }
        format.json { render json: @fish_specy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /fish_species/1
  # PUT /fish_species/1.json
  def update
    @fish_specy = FishSpecy.find(params[:id])

    respond_to do |format|
      if @fish_specy.update_attributes(params[:fish_specy])
        format.html { redirect_to @fish_specy, notice: 'Fish specy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fish_specy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fish_species/1
  # DELETE /fish_species/1.json
  def destroy
    @fish_specy = FishSpecy.find(params[:id])
    @fish_specy.destroy

    respond_to do |format|
      format.html { redirect_to fish_species_url }
      format.json { head :ok }
    end
  end
end
