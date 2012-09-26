class MessagesController < ApplicationController

  def index
    @messages = Message.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
  end

  def show
    @message = Message.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  def new
    #@to_user will just be nil if ?uid=123 is not passed in 
    @to_user = User.find(params[:uid]) if params[:uid]

    @conversation = Conversation.new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.conversation.updated_at = Time.now()
    @message.conversation.new_message = true;
    @message.conversation.save()

    Notification.create(
      user_id: @message.getUserId(current_user),
      notification_type: NotificationType.find_by_name("message"),
      title: "You have a message from #{User.find(@message.getUserId(current_user))}.",
      message: "#{@message}",
      related_id: @message.conversation.id
    )

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message.conversation}
        format.json { render json: @message.conversation, status: :created, location: @message.conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :ok }
    end
  end
end
