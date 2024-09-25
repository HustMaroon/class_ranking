class AddExplicitCiteriasToScoringRecords < ActiveRecord::Migration[7.0]
  def change
    remove_column :scoring_records, :criteria, :integer
    add_column :scoring_records, :attendees, :integer, null: false
    add_column :scoring_records, :cleaness, :integer, null: false
    add_column :scoring_records, :clothing, :integer, null: false
    add_column :scoring_records, :outdoor_act, :integer, null: false
    add_column :scoring_records, :note, :string, null: false
  end
end
