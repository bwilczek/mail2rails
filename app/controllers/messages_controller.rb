class MessagesController < ApplicationController
  def show
    render json: Message.find(params[:id])
  end

  def index
    render json: Message.all
  end
end
