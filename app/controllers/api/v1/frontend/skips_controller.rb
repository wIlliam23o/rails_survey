module Api
  module V1
    module Frontend
      class SkipsController < ApiApplicationController
        respond_to :json

        def create
          option = current_project.options.find(params[:option_id])
          @skip = option.skips.new(skip_params)
          if @skip.save
            render json: @skip, status: :created
          else
            render nothing: true, status: :unprocessable_entity
          end
        end

        def update
          option = current_project.options.find(params[:option_id])
          skip = option.skips.find(params[:id])
          respond_with skip.update_attributes(skip_params)
        end

        def destroy
          option = current_project.options.find(params[:option_id])
          skip = option.skips.find(params[:id])
          respond_with skip.destroy
        end

        private

        def skip_params
          params.require(:skip).permit(:option_id, :question_identifier)
        end
      end
    end
  end
end
