class ConversationsController < ApplicationController
  
  def index
    @conversations = Conversation.find_all_by_user_id1(current_user.id)
    Conversation.find_all_by_user_id2(current_user.id).each do |c|
      @conversations.push(c)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  def show
    @messages = Message.find_all_by_conversation_id(params[:id])
    @message = Message.new({:conversation_id => params[:id]})
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  def new
    #@to_user will just be nil if ?uid=123 is not passed in 
    @to_user = User.find(params[:uid]) if params[:uid]

    @conversation = Conversation.new
    @conversation.messages.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @conversation }
    end
  end

  def create
    @conversation = Conversation.new(params[:conversation])
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Message successfully sent.' }
        format.json { render json: @conversation, status: :created, location: @conversation }
      else
        format.html { render action: "new" }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    respond_to do |format|
      format.html { redirect_to conversations_url }
      format.json { head :ok }
    end
  end
end
