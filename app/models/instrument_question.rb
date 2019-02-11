# frozen_string_literal: true

# == Schema Information
#
# Table name: instrument_questions
#
#  id                   :integer          not null, primary key
#  question_id          :integer
#  instrument_id        :integer
#  number_in_instrument :integer
#  display_id           :integer
#  created_at           :datetime
#  updated_at           :datetime
#  identifier           :string
#  deleted_at           :datetime
#  table_identifier     :string
#

class InstrumentQuestion < ActiveRecord::Base
  belongs_to :instrument, touch: true
  belongs_to :question
  belongs_to :display, touch: true
  has_many :next_questions, dependent: :destroy
  has_many :multiple_skips, dependent: :destroy
  has_many :follow_up_questions, dependent: :destroy
  has_many :condition_skips, dependent: :destroy
  has_many :translations, through: :question
  has_many :display_instructions, dependent: :destroy
  has_many :loop_questions, dependent: :destroy
  has_many :all_loop_questions, -> { with_deleted }, class_name: 'LoopQuestion'
  has_many :critical_responses, through: :question
  acts_as_paranoid
  has_paper_trail
  validates :identifier, presence: true
  validates :identifier, uniqueness: { scope: :instrument_id,
                                       message: 'instrument already has this identifier' }
  after_update :update_display_instructions, if: :number_in_instrument_changed?
  after_destroy :renumber_questions

  def letters
    ('a'..'z').to_a
  end

  def hashed_options
    hash = {}
    non_special_options.each do |option|
      hash[option.identifier] = option
    end
    hash
  end

  def options
    non_special_options + special_options
  end

  def question_type
    question.question_type
  end

  def text
    question.text
  end

  def translated_text(language)
    return question.text if language == instrument.language

    translation = question.translations.where(language: language).first
    translation&.text ? translation.text : question.text
  end

  def loop_string
    return if loop_questions.blank?

    skipped = +''
    loop_questions.each do |loop_question|
      q = instrument.instrument_questions.where(identifier: loop_question.looped).first
      skipped << "<b>##{q.number_in_instrument}</b>, "
    end
    "-> Ask questions #{skipped.strip.chop} for each of the responses"
  end

  def slider_variant?
    question.slider_variant?
  end

  def select_one_variant?
    question.select_one_variant?
  end

  def select_multiple_variant?
    question.select_multiple_variant?
  end

  def list_of_boxes_variant?
    question.list_of_boxes_variant?
  end

  def non_special_options?
    !non_special_options.empty?
  end

  def other?
    question.other?
  end

  def non_special_options
    question.option_set_id ? question.option_set.options : []
  end

  def special_options
    question.special_option_set_id ? question.special_option_set.options : []
  end

  def copy(display_id, instrument_id)
    iq_copy = dup
    iq_copy.display_id = display_id
    iq_copy.instrument_id = instrument_id
    i = Instrument.find instrument_id
    iq_copy.number_in_instrument = i.instrument_questions.size + 1
    iq_copy.save!
    next_questions.each do |nq|
      nq_copy = nq.dup
      nq_copy.instrument_question_id = iq_copy.id
      nq_copy.save!
    end
    multiple_skips.each do |ms|
      ms_copy = ms.dup
      ms_copy.instrument_question_id = iq_copy.id
      ms_copy.save!
    end
    follow_up_questions.each do |fuq|
      fuq_copy = fuq.dup
      fuq_copy.instrument_question_id = iq_copy.id
      fuq_copy.save!
    end
  end

  private

  def update_display_instructions
    display_instructions.update_all(position: number_in_instrument)
  end

  def renumber_questions
    instrument.renumber_questions
  end
end
