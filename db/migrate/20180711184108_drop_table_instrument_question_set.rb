class DropTableInstrumentQuestionSet < ActiveRecord::Migration
  def change
    drop_table :instrument_question_sets
  end
end
