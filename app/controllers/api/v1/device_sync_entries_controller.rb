# frozen_string_literal: true

module Api
  module V1
    class DeviceSyncEntriesController < ApiApplicationController
      protect_from_forgery with: :null_session
      respond_to :json

      def create
        device = Device.includes(:projects).find_by_identifier(params[:device_sync_entry][:device_uuid])
        project = Project.find_by_id(params[:device_sync_entry][:project_id])
        if device
          device.projects << project if project && !device.projects.include?(project)
          device.update(label: params[:device_sync_entry][:device_label]) if device.label != params[:device_sync_entry][:device_label]
        else
          device = Device.new
          device.projects << project if project && !device.projects.include?(project)
          device.identifier = params[:device_sync_entry][:device_uuid]
          device.label = params[:device_sync_entry][:device_label]
          device.save
        end
        @device_sync_entry = DeviceSyncEntry.new(device_sync_entry_params)
        if @device_sync_entry.save
          render json: @device_sync_entry, status: :created
        else
          render nothing: true, status: :unprocessable_entity
        end
      end

      private

      def device_sync_entry_params
        params.require(:device_sync_entry).permit(:latitude, :longitude, :num_complete_surveys,
                                                  :current_language, :current_version_code, :instrument_versions, :api_key, :device_uuid,
                                                  :timezone, :current_version_name, :os_build_number, :project_id, :num_incomplete_surveys, :device_label)
      end
    end
  end
end
