class CreateShowings < ActiveRecord::Migration[7.0]
  def change
    create_table(:showings) do |t|
      t.belongs_to(:cinema, foreign_key: true)
      t.belongs_to(:movie, foreign_key: true)
      t.belongs_to(:timeslot, foreign_key: true)

      t.index([:cinema_id, :timeslot_id], unique: true)

      t.timestamps
    end
  end
end
