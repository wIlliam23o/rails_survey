# == Schema Information
#
# Table name: section_translations
#
#  id                        :integer          not null, primary key
#  section_id                :integer
#  language                  :string
#  text                      :string
#  created_at                :datetime
#  updated_at                :datetime
#  section_changed           :boolean          default(FALSE)
#  instrument_translation_id :integer
#

class SectionTranslation < ActiveRecord::Base
  include GoogleTranslatable
  belongs_to :section, touch: true
  belongs_to :instrument_translation, touch: true
  validates :text, presence: true, allow_blank: false

  def translate_using_google
    text_translation = translation_client.translate sanitize_text(section.title), to: language unless section.title.blank?
    self.text = text_translation.text if text_translation
    save
  end
end
