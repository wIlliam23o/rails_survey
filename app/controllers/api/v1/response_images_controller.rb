module Api
  module V1
    class ResponseImagesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @response = ResponseImage.new(:response_uuid => params[:response_uuid], :picture => params[:picture])
        if @response.save
          render json: @response, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end
      
    end
  end
end
