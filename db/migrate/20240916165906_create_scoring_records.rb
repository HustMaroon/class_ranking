class CreateScoringRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :scoring_records do |t|
      t.references :user
      t.references :klass
      t.integer :criteria
      t.integer :score

      t.timestamps
    end
  end
end
