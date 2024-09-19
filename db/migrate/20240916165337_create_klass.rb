class CreateKlass < ActiveRecord::Migration[7.0]
  def change
    create_table :klasses do |t|
      t.string :name
      t.integer :attendees
      t.timestamps
    end
  end
end
