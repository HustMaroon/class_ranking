class AddAssessmentDateToScoringRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :scoring_records, :assessment_date, :date, null: false
  end
end
