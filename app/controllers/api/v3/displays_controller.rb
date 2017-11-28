module Api
  module V3
    class DisplaysController < Api::V1::ApiApplicationController
      respond_to :json
      def index
        project = Project.find params[:project_id]
        @displays = project.displays
      end
    end
  end
end
