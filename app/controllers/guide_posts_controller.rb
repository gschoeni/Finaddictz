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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @guide_post }
    end
  end

  # GET /guide_posts/1/edit
  def edit
    @guide_post = GuidePost.find(params[:id])
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

  def abuse_email
    AbuseMailer.abuse_email.deliver
  end      
end
