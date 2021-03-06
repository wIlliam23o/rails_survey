# frozen_string_literal: true

module Api
  module V1
    class SurveysController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        @survey = Survey.find_or_create_by(uuid: params[:survey][:uuid])
        record_device_attributes
        if @survey.update_attributes(survey_params)
          render json: @survey, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end

      private

      def record_device_attributes
        device = Device.find_or_create_by(identifier: params[:survey][:device_uuid])
        @survey.device = device
        project = Project.find_by_id(params[:project_id])
        device.projects << project unless device.projects.include?(project)
        device.identifier = params[:survey][:device_uuid]
        device.label = params[:survey][:device_label]
        device.save
      end

      def survey_params
        params.require(:survey).permit(:instrument_id, :instrument_version_number,
                                       :uuid, :device_id, :instrument_title, :device_uuid, :latitude, :longitude,
                                       :metadata, :completion_rate, :device_label, :language, :skipped_questions,
                                       :completed_responses_count)
      end
    end
  end
end
