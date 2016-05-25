class MessagesController < ApplicationController
  before_action :load_inbox_messages, only: [:inbox_index_json, :inbox_index]
  before_action :load_inbox_message, only: [:inbox_message_json, :inbox_message]
  
  def inbox_index_json
    render json: @messages
  end

  def inbox_index
    if @messages.empty?
      render text: "There are no messages for inbox #{params[:inbox]}"
      return
    end
  end
  
  def inbox_message_json
    render json: @message
  end
  
  def inbox_message
  end
  
  private
  
  def load_inbox_messages
    @messages = Message.where(inbox: params[:inbox])
  end

  def load_inbox_message
    @message = Message.where(id: params[:id], inbox: params[:inbox]).first
  end
  
end
