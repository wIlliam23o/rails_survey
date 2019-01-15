class MakeUuidIndicesUnique < ActiveRecord::Migration
  def change
    remove_index :responses, column: :uuid
    remove_index :surveys, column: :uuid
    add_index :responses, :uuid, unique: true
    add_index :surveys, :uuid, unique: true
  end
end
