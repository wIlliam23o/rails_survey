class CreateInstructionTranslations < ActiveRecord::Migration
  def change
    create_table :instruction_translations do |t|
      t.integer :instruction_id
      t.string :language
      t.text :text
      t.timestamps null: false
    end
  end
end
