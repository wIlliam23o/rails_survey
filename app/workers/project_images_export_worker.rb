class ProjectImagesExportWorker
  include Sidekiq::Worker

  def perform(project_id, zipped_file, pictures_export_id)
    project = Project.find project_id
    if project.response_images
      project.response_images.to_zip(project.name, zipped_file, pictures_export_id)
    end
  end
  
end