module Api
  module V2
    class ResponseImagesController < ApiApplicationController

      def create
        @response = ResponseImage.new(response_image_params)
        if @response.save
          render json: @response, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end

      private
      def response_image_params
        params.require(:response_image).permit(:picture, :response_uuid, :picture_file_name, :picture_content_type,
                                               :picture_file_size, :picture_updated_at, :picture_data)
      end

    end
  end
end