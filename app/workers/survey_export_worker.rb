class SurveyExportWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'export'

  def perform(survey_uuid)
    survey = get_survey(survey_uuid)
    survey.write_short_row
    survey.write_long_row
    survey.write_wide_row
  end

  def get_survey(survey_uuid)
    key = Response.where(survey_uuid: survey_uuid).maximum('updated_at')
    Rails.cache.fetch("survey-#{survey_uuid}-#{key}", expires_in: 30.minutes) do
      Survey.includes(:responses).where(uuid: survey_uuid).try(:first)
    end
  end
end
