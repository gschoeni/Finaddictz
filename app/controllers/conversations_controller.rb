class ConversationsController < ApplicationController
  
  def index
    @conversations = Conversations.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @conversations }
    end
  end

  def show
    @messages = Messages.find_by_conversation_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  def new
    @conversation = Conversation.new

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
