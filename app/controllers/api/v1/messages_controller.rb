class Api::V1::MessagesController < ApplicationController

  def index 
    received_messages = current_user.received_messages.where(received_visible: true).map(&:clone)
    sent_messages = current_user.sent_messages.where(sent_visible: true).map(&:clone)
    messages = received_messages.concat(sent_messages).sort()
    if  messages
      render json: {
        status: 200,
        messages: MessageSerializer.new(messages)
      } 
    else 
      render json: {
        status: 500,
        error: ["No record found!"]
      }
    end
  end
    
  def create 
     message = Message.create(content: params[:message][:content], user_id: current_user.id, match_id: params[:message][:match_id])
    if params[:message][:content]  != ""
      render json: {
        status: 200,
        message: message,
        sent_messages: MessageSerializer.new(message)
      }
    else 
      render json: {
        status: 409,
        error:  message.errors.messages[:content]
      }
    end
  end

  def outbox
    messages = current_user.sent_messages.where(sent_visible: true).desc_order
    if messages 
      render json: {
        status: 200,
        sent_messages: MessageSerializer.new(messages),
      }
    else 
      render json: {
        status: 500,
        message: ["No Record Found!"]
      }
    end
  end

  def inbox
    messages = current_user.received_messages.where(received_visible: true).desc_order
    if messages
      render json: {
        status: 200,
        received_messages: MessageSerializer.new(messages)
      }
    else 
      render json: {
        status: 500,
        message: ["No Record Found!"]
      }
    end
  end

  def update_send_message 
    message = current_user.sent_messages.find(params[:id]) 
    if message.update(content: params[:content], sent_visible: false)
      render json: {
        status: 200,
        message: message
      }
    else 
      render json: {
        status: 500,
        errors: message.errors.full_messages
      }
    end
  end

  def update_received_message 
    message = current_user.received_messages.find(params[:id]) 
    if message.update(content: params[:content], received_visible: false)
      render json: {
        status: 200,
        message: message
      }
    else 
      render json: {
        status: 500,
        errors: message.errors.full_messages
      }
    end
  end

  private 

  def message_params
    params.require(:message).permit(:content, :visible, :user_id, :match_id)
  end
end
