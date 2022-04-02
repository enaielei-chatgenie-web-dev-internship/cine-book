class CreateTimeslots < ActiveRecord::Migration[7.0]
  def change
    create_table(:timeslots) do |t|
      t.time(:time)
      t.string(:label)

      t.timestamps
    end
  end
end
