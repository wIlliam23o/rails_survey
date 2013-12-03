class InstrumentTranslationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translations = @instrument.instrument_translations.all
  end

  def show
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
  end

  def new
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.new
  end

  def create
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.new(params[:instrument_translation])
    update_translations(params, @instrument, @instrument_translations)
    if @instrument_translation.save
      redirect_to instrument_instrument_translation_path(@instrument, @instrument_translation),
        notice: "Successfully created instrument translation."
    else
      render :new
    end
  end

  def edit
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
  end

  def update
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
    update_translations(params, @instrument, @instrument_translation)
    if @instrument_translation.update_attributes!(params[:instrument_translation])
      redirect_to instrument_instrument_translation_path(@instrument, @instrument_translation),
        notice: "Successfully updated instrument translation."
    else
      render :edit
    end
  end

  def destroy
    @instrument = Instrument.find(params[:instrument_id])
    @instrument_translation = @instrument.instrument_translations.find(params[:id])
    @instrument_translation.destroy
    redirect_to instrument_translations_url, notice: "Successfully destroyed instrument translation."
  end

  private

  def update_translations(params, instrument, instrument_translation)
    params[:question_translations].each_pair do |question_id, translation|
      question = instrument.questions.find(question_id)
      question_translation = question.question_translations.where(
        language: instrument_translation.language,
        question_id: question.id
      ).first_or_initialize
      question_translation.text = translation
      question_translation.save!
    end
  end
end