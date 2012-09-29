class AnglerPostsController < ApplicationController
  # GET /angler_posts
  # GET /angler_posts.json
  def index 
    if params == {"action"=>"index", "controller"=>"angler_posts"}
      params.merge!({:price_min => 0, :price_max => 1000})
    end
    @angler_posts = AnglerPost.fullSearch(params)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @angler_posts }
    end
  end

  # GET /angler_posts/1
  # GET /angler_posts/1.json
  def show
    @angler_post = AnglerPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @angler_post }
    end
  end

  # GET /angler_posts/new
  # GET /angler_posts/new.json
  def new
    @angler_post = AnglerPost.new
    @rivers = River.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @angler_post }
    end
  end

  # GET /angler_posts/1/edit
  def edit
    @angler_post = AnglerPost.find(params[:id])
    @rivers = River.all
  end

  # POST /angler_posts
  # POST /angler_posts.json
  def create
    @angler_post = AnglerPost.new(params[:angler_post])

    respond_to do |format|
      if @angler_post.save
        format.html { redirect_to @angler_post, notice: 'Angler post was successfully created.' }
        format.json { render json: @angler_post, status: :created, location: @angler_post }
      else
        format.html { render action: "new" }
        format.json { render json: @angler_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /angler_posts/1
  # PUT /angler_posts/1.json
  def update
    @angler_post = AnglerPost.find(params[:id])

    respond_to do |format|
      if @angler_post.update_attributes(params[:angler_post])
        format.html { redirect_to @angler_post, notice: 'Angler post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @angler_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /angler_posts/1
  # DELETE /angler_posts/1.json
  def destroy
    @angler_post = AnglerPost.find(params[:id])
    @angler_post.destroy

    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Your post has been deleted.' }
      format.json { head :ok }
    end
  end

  def book_trip
    @angler_post = AnglerPost.find(params[:id])
    @angler_post.booking_status_id = BookingStatus.find_by_status("Booked").id;
 
    if @angler_post.save
      redirect_to current_user, notice: "Your trip has been marked as booked."
    else
      redirect_to current_user, notice: 'Something went wrong..'
    end
  end 

end
