class GuidePostsController < ApplicationController
  helper_method :valid_date_string
  # GET /guide_posts
  # GET /guide_posts.json
  def index

    @guide_posts  = GuidePost.fullSearch(params)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @guide_posts }
    end
  end

  # GET /guide_posts/1
  # GET /guide_posts/1.json
  def show
    @guide_post = GuidePost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @guide_post }
    end
  end

  # GET /guide_posts/new
  # GET /guide_posts/new.json
  def new
    @guide_post = GuidePost.new
    @rivers = River.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guide_post }
    end
  end

  # GET /guide_posts/1/edit
  def edit
    @guide_post = GuidePost.find(params[:id])
    @rivers = River.all
  end

  # POST /guide_posts
  # POST /guide_posts.json
  def create

    @guide_post = GuidePost.new(params[:guide_post])

    respond_to do |format|
      if @guide_post.save
        format.html { redirect_to @guide_post, notice: 'Guide post was successfully created.' }
        format.json { render json: @guide_post, status: :created, location: @guide_post }
      else
        format.html { render action: "new" }
        format.json { render json: @guide_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /guide_posts/1
  # PUT /guide_posts/1.json
  def update
    @guide_post = GuidePost.find(params[:id])

    respond_to do |format|
      if @guide_post.update_attributes(params[:guide_post])
        format.html { redirect_to @guide_post, notice: 'Guide post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @guide_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /guide_posts/1
  # DELETE /guide_posts/1.json
  def destroy
    @guide_post = GuidePost.find(params[:id])
    @guide_post.destroy

    respond_to do |format|
      format.html { redirect_to guide_posts_url }
      format.json { head :ok }
    end
  end

  def flag_as_abused
    @guide_post = GuidePost.find(params[:id])
    @guide_post.abusive_flag = true;
    if @guide_post.save
      AbuseMailer.abuse_email.deliver
      redirect_to @guide_post, notice: 'Guide post was flagged as abusive'
    else
      redirect_to @guide_post, notice: 'Something went wrong..'
    end
  end  

  def book_trip
    @guide_post = GuidePost.find(params[:id])
    @guide_post.booking_status_id = BookingStatus.find_by_status("Pending").id;
    
    #insert into trips users table here!
    TripsToUser.create(
      post_id: @guide_post.id,
      post_booking_status_id: @guide_post.booking_status_id,
      user_who_posted_id: @guide_post.user.id,
      user_who_agreed_id: current_user.id
    )

    Notification.create(
      user_id: @guide_post.user.id,
      notification_type: NotificationType.find_by_name("trip_booking").id,
      title: "Your post '#{@guide_post.title}' has a booking request",
      message: "",
      related_id: @guide_post.id
    )

    if @guide_post.save
      redirect_to @guide_post, notice: 'The guide has been notified of your interest!'
    else
      redirect_to @guide_post, notice: 'Something went wrong..'
    end
  end 

end
