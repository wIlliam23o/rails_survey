# == Schema Information
#
# Table name: section_translations
#
#  id         :integer          not null, primary key
#  section_id :integer
#  language   :string(255)
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class SectionTranslation < ActiveRecord::Base
  attr_accessible :language, :text
  belongs_to :section
  validates :text, presence: true, allow_blank: false
end
