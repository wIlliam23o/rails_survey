module Api
  module V2
    class SurveysController < ApiApplicationController

      def create
        @survey = Survey.new(survey_params)
        device = Device.find_by identifier: params[:survey][:device_uuid]
        if device
          @survey.device = device
          project = Project.find_by_id(params[:project_id])
          device.projects << project unless device.projects.include?(project)
          device.update(label: params[:survey][:device_label]) if device.label != params[:survey][:device_label]
        else
          device = Device.new
          device.projects << Project.find_by_id(params[:project_id])
          device.identifier = params[:survey][:device_uuid]
          device.label = params[:survey][:device_label]
          device.save
          @survey.device = device
        end

        if @survey.save
          render json: @survey, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end

      private
      def survey_params
        params.require(:survey).permit(:instrument_id, :instrument_version_number, :uuid, :device_id,
                                       :instrument_title, :device_uuid, :latitude, :longitude, :metadata,
                                       :completion_rate, :device_label, :has_critical_responses, :roster_uuid)
      end
    end
  end
end