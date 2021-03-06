# == Schema Information
#
# Table name: question_randomized_factors
#
#  id                   :integer          not null, primary key
#  question_id          :integer
#  randomized_factor_id :integer
#  position             :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class QuestionRandomizedFactor < ActiveRecord::Base
  belongs_to :question, touch: true
  belongs_to :randomized_factor
  validates :question_id, presence: true
  validates :randomized_factor_id, presence: true
  validates :position, presence: true
end
