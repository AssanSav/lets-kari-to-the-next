class Api::V1::MessagesController < ApplicationController
    
    def create 
      binding.pry
      message = current_user.messsages.create!(message_params)
      if message 
        render json: {
          status: 200,
          message: message
        }
      else 
        render json: {
          status: 409,
          error: message.errors.full_messages
        }
      end
    end

    def outbox
      messages = current_user.received_messages
      if messages 
        render json: {
          status: 200,
          received_messages: messages
        }
      else 
        render json: {
          status: 500,
          message: ["No Record Found!"]
        }
      end
    end

    def inbox
    end

    private 

    def message_params
      params.require(:message).permit(:content, :user_id, :match_id)
    end
end
