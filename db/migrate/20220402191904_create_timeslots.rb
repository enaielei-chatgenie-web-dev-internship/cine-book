class CreateTimeslots < ActiveRecord::Migration[7.0]
  def change
    create_table(:timeslots) do |t|
      t.time(:time, default: Time.now())
      t.string(:label)

      t.index(:time, unique: true)

      t.timestamps
    end
  end
end
