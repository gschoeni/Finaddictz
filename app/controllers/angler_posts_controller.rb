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
    @rivers = River.all
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
    
    invalid_date = current_user.has_conflicting_trip(@angler_post)
    unless current_user.has_conflicting_trip(@angler_post)
      @angler_post.booking_status_id = BookingStatus.find_by_status("Booked").id;
    end
    puts invalid_date

    if @angler_post.save and !invalid_date
      redirect_to current_user, notice: "Your trip has been marked as booked."
    elsif invalid_date
      redirect_to current_user, notice: "You already have a trip scheduled for this day."
    else 
      redirect_to current_user, notice: 'Something went wrong..'
    end
  end 

  def flag_as_abused
    @angler_post = AnglerPost.find(params[:id])
    @angler_post.abusive_flag = true;
    if @angler_post.save
      AbuseMailer.abuse_email.deliver
      redirect_to @angler_post, notice: 'Angler post was flagged as abusive.'
    else
      redirect_to @angler_post, notice: 'Cannot flag this post as abusive.'
    end
  end 

  def flag_as_not_abused
    @angler_post = AnglerPost.find(params[:id])
    @angler_post.abusive_flag = false;
    if @angler_post.save
      redirect_to abusive_posts_path(1), notice: 'Angler Post was flagged as unabusive.'
    else
      redirect_to abusive_posts_path(1), notice: 'Something went wrong..'
    end
  end 

end
