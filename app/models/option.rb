# == Schema Information
#
# Table name: options
#
#  id                 :integer          not null, primary key
#  question_id        :integer
#  text               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  next_question      :string(255)
#  number_in_question :integer
#  deleted_at         :datetime
#

class Option < ActiveRecord::Base
  include Translatable
  default_scope { order('number_in_question ASC') }
  attr_accessible :question_id, :text, :next_question, :number_in_question
  belongs_to :question
  delegate :instrument, to: :question
  delegate :project, to: :question
  has_many :translations, foreign_key: 'option_id', class_name: 'OptionTranslation', dependent: :destroy
  before_save :update_instrument_version, if: Proc.new { |option| option.changed? }
  before_destroy :update_instrument_version
  has_paper_trail
  acts_as_paranoid

  validates :text, presence: true, allow_blank: false

  def to_s
    text
  end

  def instrument_version
    instrument.current_version_number
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:instrument_version]
    }))
  end

  private
  def update_instrument_version
    instrument.update_instrument_version
  end
end
