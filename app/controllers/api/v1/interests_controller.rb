class Api::V1::InterestsController < ApplicationController

  def index
    render json: {
      interests: Interest.all
    }
  end

end
