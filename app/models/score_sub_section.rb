# == Schema Information
#
# Table name: score_sub_sections
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  score_section_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class ScoreSubSection < ActiveRecord::Base
  attr_accessible :name, :score_section_id
  has_many :units, dependent: :destroy
  has_many :unit_scores, through: :units
  has_many :survey_scores, through: :units
  belongs_to :score_section
end