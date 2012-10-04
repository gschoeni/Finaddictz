class GuidePostsController < ApplicationController
  helper_method :valid_date_string
  # GET /guide_posts
  # GET /guide_posts.json
  def index
    if params == {"action"=>"index", "controller"=>"guide_posts"}
      params.merge!({:price_min => 0, :price_max => 1000})
    end
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
    @post_is_booked = true if @guide_post.booking_status == BookingStatus.find_by_status("Booked")
    @post_is_pending = true if @guide_post.booking_status == BookingStatus.find_by_status("Pending")
    if @post_is_pending
      @pending_users = TripsToUser.find_all_by_post_id(params[:id]).count()
    end

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
    interested_users = TripsToUser.find_all_by_post_id(params[:id])
    @interested_users = []
    @accepted_users = []
    interested_users.each do |trip|
      if trip.accepted
        @accepted_users.push({"user" => User.find_by_id(trip.user_who_agreed_id), "trip_id" => trip.id})
      else
        @interested_users.push({"user" => User.find_by_id(trip.user_who_agreed_id), "trip_id" => trip.id})
      end
    end
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
    @rivers = River.all
    interested_users = TripsToUser.find_all_by_post_id(params[:id])
    @interested_user_count = interested_users.count()
    @users = []
    interested_users.each do |u|
      @users.push(User.find_by_id(u.user_who_agreed_id))
    end

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
      format.html { redirect_to current_user, notice: 'Your post has been deleted.' }
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

    already_booked_this_trip = TripsToUser.find_by_post_id_and_user_who_agreed_id(params[:id], current_user.id)
    already_has_trip_on_this_day = current_user.has_conflicting_trip(@guide_post)

    unless already_booked_this_trip || already_has_trip_on_this_day
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
        title: "#{current_user} has requested to book your trip: '#{@guide_post.title}'",
        message: "",
        related_id: @guide_post.id
      )

      if @guide_post.save
        redirect_to @guide_post, notice: 'The guide has been notified of your interest!'
      else
        redirect_to @guide_post, notice: 'Something went wrong..'
      end
    else 
      if already_has_trip_on_this_day
        redirect_to @guide_post, notice: 'You already have a trip booked for this day.'
      else 
        redirect_to @guide_post, notice: 'You have already sent a request for booking this trip.'
      end
    end
  end 

  def remove_user_from_trip
    @guide_post = GuidePost.find(params[:id])
    @trip = TripsToUser.find_by_post_id_and_user_who_agreed_id(params[:id], params[:user_id])
    @trip.destroy

    Notification.create(
      user_id: @trip.user_who_agreed_id,
      notification_type: NotificationType.find_by_name("trip_full").id,
      title: "Trip Full",
      message: "Unfortunately your trip with #{@guide_post.user} is full, you can contact #{@guide_post.user} for more details.",
      related_id: @guide_post.id
    )

    redirect_to edit_guide_post_url(params[:id]), notice: 'User has been informed that this slot has been taken.'
  end

end
