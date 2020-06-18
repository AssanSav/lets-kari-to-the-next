class Api::V1::MessagesController < ApplicationController
    
    def create 
      message = Message.create!(content: params[:message][:content], user_id: current_user.id, match_id: params[:message][:match_id])
      if message 
        render json: {
          status: 200,
          message: message,
          sent_messages: current_user.sent_messages
        }
      else 
        render json: {
          status: 409,
          error: message.errors.full_messages
        }
      end
    end

    def outbox
      messages = current_user.sent_messages
      if messages 
        render json: {
          status: 200,
          sent_messages: MessageSerializer.new(current_user.sent_messages),
        }
      else 
        render json: {
          status: 500,
          message: ["No Record Found!"]
        }
      end
    end

    def inbox
      messages = current_user.received_messages
      if messages
        render json: {
          status: 200,
          received_messages: MessageSerializer.new(current_user.received_messages),
        }
      else 
        render json: {
          status: 500,
          message: ["No Record Found!"]
        }
      end
    end

    private 

    def message_params
      params.require(:message).permit(:content, :user_id, :match_id)
    end
end
