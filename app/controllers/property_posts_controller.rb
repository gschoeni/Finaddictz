class PropertyPostsController < ApplicationController
  # GET /property_posts
  # GET /property_posts.json
  def index
    @property_posts = PropertyPost.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @property_posts }
    end
  end

  # GET /property_posts/1
  # GET /property_posts/1.json
  def show
    @property_post = PropertyPost.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property_post }
    end
  end

  # GET /property_posts/new
  # GET /property_posts/new.json
  def new
    @property_post = PropertyPost.new
    @rivers = River.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property_post }
    end
  end

  # GET /property_posts/1/edit
  def edit
    @property_post = PropertyPost.find(params[:id])
    @rivers = River.all
  end

  # POST /property_posts
  # POST /property_posts.json
  def create
    @property_post = PropertyPost.new(params[:property_post])
    @rivers = River.all
    respond_to do |format|
      if @property_post.save
        format.html { redirect_to @property_post, notice: 'Property post was successfully created.' }
        format.json { render json: @property_post, status: :created, location: @property_post }
      else
        format.html { render action: "new" }
        format.json { render json: @property_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /property_posts/1
  # PUT /property_posts/1.json
  def update
    @property_post = PropertyPost.find(params[:id])
    @rivers = River.all
    respond_to do |format|
      if @property_post.update_attributes(params[:property_post])
        format.html { redirect_to @property_post, notice: 'Property post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @property_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /property_posts/1
  # DELETE /property_posts/1.json
  def destroy
    @property_post = PropertyPost.find(params[:id])
    @property_post.destroy

    respond_to do |format|
      format.html { redirect_to property_posts_url }
      format.json { head :ok }
    end
  end

  def flag_as_abused
    @property_post = PropertyPost.find(params[:id])
    @property_post.abusive_flag = true;
    if @property_post.save
      AbuseMailer.abuse_email.deliver
      redirect_to @property_post, notice: 'Property post was flagged as abusive'
    else
      redirect_to @property_post, notice: 'Cannot flag this post as abusive.'
    end
  end 

  def flag_as_not_abused
    @property_post = PropertyPost.find(params[:id])
    @property_post.abusive_flag = false;
    if @property_post.save
      redirect_to abusive_posts_path(1), notice: 'Property post was flagged as unabusive.'
    else
      redirect_to abusive_posts_path(1), notice: 'Something went wrong..'
    end
  end  
end
