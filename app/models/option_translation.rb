# == Schema Information
#
# Table name: option_translations
#
#  id                        :integer          not null, primary key
#  option_id                 :integer
#  text                      :text
#  language                  :string
#  created_at                :datetime
#  updated_at                :datetime
#  option_changed            :boolean          default(FALSE)
#  instrument_translation_id :integer
#

class OptionTranslation < ActiveRecord::Base
  include GoogleTranslatable
  belongs_to :option, touch: true
  has_many :back_translations, as: :backtranslatable
  belongs_to :instrument_translation, touch: true
  validates :text, presence: true, allow_blank: false

  def translate_using_google
    text_translation = translation_client.translate sanitize_text(option.text), to: language unless option.text.blank?
    self.text = text_translation.text if text_translation
    save
  end
end
